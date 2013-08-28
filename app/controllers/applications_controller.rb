class ApplicationsController < ApplicationController
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

  def administrate_group
    @features = current_application.features #TODO: exclude features in group
    @feature_group = current_application.feature_group.features
  end

  def add_feature_request_to_group
    @feature = get_feature
    @feature.feature_group = current_application.feature_group
    respond_to_js @feature
  end

  def remove_feature_request_from_group
    @feature = get_feature
    @feature.feature_group = nil
    respond_to_js @feature
  end

  private

  def current_application
    @current_application ||= current_customer.applications.find(params[:id])
  end
  helper_method :current_application

  def feature_attributes
    params.require(:feature).permit(:title, :description)
  end

  def get_feature
    current_application.features.find(params[:fid])
  end

  def respond_to_js(feature)
    respond_to do |format|
      if feature.save!
        format.js {  }
      end
    end
  end
end
