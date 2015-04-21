class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
  before_filter :set_controller_and_action_names

  before_filter :set_new_relic if Rails.env == 'production' || Rails.env == 'staging'

  include CurrentCustomer


  private

  helper_method :current_customer

  def applications
    @applications ||= current_customer.applications.to_a.delete_if{|a| a.new_record?} if current_customer
  end
  helper_method :applications

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_customer.nil?
  end

  def set_controller_and_action_names
    @current_controller = controller_name
    @current_action     = action_name
  end

  def set_new_relic
    puts "params is #{params}"
    ::NewRelic::Agent.add_custom_parameters(
        params: params
    )
  end

end
