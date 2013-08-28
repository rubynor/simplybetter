class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def administrate
    @application = current_customer.applications.find(params[:id])
  end

  def new_feature
    @feature = Feature.new
  end

  def create_feature
    @feature = Feature.new(params[:feature])
    @feature.application = current_application
    @feature.creator = current_customer
    respond_to do |format|
      if @feature.save!
        format.html { redirect_to application_new_feature_path(current_application.id), notice: 'Feature was successfully created.' }
      end
    end
  end

  private

  def current_customer
    @current_customer ||= Customer.find(session[:customer_id]) if session[:customer_id]
  end
  helper_method :current_customer

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_customer.nil?
  end

  def current_application
    @current_application ||= current_customer.applications.find(params[:id])
  end
  helper_method :current_application

end
