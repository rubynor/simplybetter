class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_customer
    @current_customer ||= Customer.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_customer

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_customer.nil?
  end
end
