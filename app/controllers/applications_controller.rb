class ApplicationsController < ApplicationController
  before_action :current_application, only: [:administrate_group]
  before_action :get_feature, only: [:edit_feature, :update_feature, :add_feature_request_to_group, :remove_feature_request_from_group, :delete_feature]

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

  def edit_feature
  end

  def update_feature
    @feature.update_attributes!(feature_attributes)
    redirect_to administrate_group_path, notice: 'Feature request was updated'
  end

  def delete_feature
    @feature.destroy!
    redirect_to administrate_group_path, notice: 'Feature request was removed'
  end

  def create
    current_customer.applications.create!(application_attributes)
    redirect_to applications_path, notice: 'Application successfully created!'
  end

  def administrate_group
    @features = current_application.features_not_in_group
    @feature_group = current_application.feature_group.features
  end

  def add_feature_request_to_group
    @feature.feature_group = current_application.feature_group
    respond_to_js
  end

  def remove_feature_request_from_group
    @feature.feature_group_id = nil
    respond_to_js
  end

  private

  def current_application
    @application ||= current_customer.applications.find(params[:id]) if params[:id]
  end
  helper_method :current_application

  def feature_attributes
    params.require(:feature).permit(:title, :description, :id)
  end
  def application_attributes
    params.require(:application).permit(:name)
  end

  def get_feature
    @feature = current_application.features.find(params[:fid])
  end

  def respond_to_js
    respond_to do |format|
      if @feature.save!
        format.js { @feature }
      end
    end
  end
end
