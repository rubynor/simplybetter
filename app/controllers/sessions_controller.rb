class SessionsController < ApplicationController
  def new
  end

  def create
    customer = Customer.find_by_email(params[:email])
    if customer && customer.authenticate(params[:password])
      session[:user_id] = customer.id
      redirect_to root_url, notice: "Logged in!"
    else
      #flash.now.alert = "Email or password is invalid"
      raise "Email or password invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
