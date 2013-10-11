class SessionsController < ApplicationController
  def new
    if current_customer
      redirect_to applications_path
    end
  end

  def create
    customer = Customer.find_by_email(params[:email])
    if customer && customer.authenticate(params[:password])
      session[:customer_id] = customer.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:customer_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
