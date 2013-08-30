class ApplicationsController < ApplicationController

  def index
    @applications = current_customer.applications.includes(:features)
    @application = Application.new
  end

  def administrate
    @application = current_application
  end

  def new_feature
    @feature = Feature.new
  end

  def create_feature
    @feature = Feature.new(feature_attributes)
    @feature.application = current_application
    @feature.creator = current_customer
    respond_to do |format|
      if @feature.save!
        format.html { redirect_to application_new_feature_path(current_application.id), notice: 'Feature request was successfully created.' }
      end
    end
  end

  def create
    current_customer.applications.create!(application_attributes)
    redirect_to action: :index, notice: 'Application successfully created!'
  end

  def administrate_group
    @features = current_application.features_not_in_group
    @feature_group = current_application.feature_group.features
  end

  def add_feature_request_to_group
    @feature = get_feature
    @feature.feature_group = current_application.feature_group
    respond_to_js
  end

  def remove_feature_request_from_group
    @feature = get_feature
    @feature.feature_group_id = nil
    respond_to_js
  end

  private

  def current_application
    @current_application ||= current_customer.applications.find(params[:id])
  end
  helper_method :current_application

  def feature_attributes
    params.require(:feature).permit(:title, :description, :id)
  end
  def application_attributes
    params.require(:application).permit(:name)
  end

  def get_feature
    current_application.features.find(params[:fid])
  end

  def respond_to_js
    respond_to do |format|
      if @feature.save!
        format.js { @feature }
      end
    end
  end
end
