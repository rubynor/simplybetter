class LandingPageController < ActionController::Base
  protect_from_forgery
  layout 'landing_page'

  include CurrentCustomer

  def index
    @priceplans = PricePlan.all
  end

  def contact_us
    if ContactFormMailer.contact_us(name: params[:name], email: params[:email], message: params[:message]).deliver
      redirect_to root_path
    end

  end

  private

  helper_method :current_customer
end
