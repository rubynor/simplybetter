class ApplicationsController < ApplicationController
  def administrate
    @application = current_customer.applications.find(params[:id])
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

  private

  def current_application
    @current_application ||= current_customer.applications.find(params[:id])
  end
  helper_method :current_application

  def feature_attributes
    params.require(:feature).permit(:title, :description)
  end
end
