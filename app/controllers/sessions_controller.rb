class SessionsController < ApplicationController
  layout "splash_screen"

  def new
    if current_customer
      redirect_to applications_path
    end
  end

  def create
    customer = Customer.find_by_email(params[:email])
    if customer && customer.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = customer.auth_token
      else
        cookies[:auth_token] = customer.auth_token
      end
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, notice: "Logged out!"
  end
end
