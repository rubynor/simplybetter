class LandingPageController < ActionController::Base
  protect_from_forgery
  layout 'landing_page'

  def index
    #nothing here...
  end

  def contact_us
    if ContactFormMailer.contact_us(name: params[:name], email: params[:email], message: params[:message]).deliver
      redirect_to root_path
    end

  end
end
