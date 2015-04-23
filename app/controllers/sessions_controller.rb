class SessionsController < ApplicationController
  layout "splash_screen"

  def new
    @post_path = '/sessions/create'
    redirect_if_already_signed_in(applications_path)
  end

  def popup_new
    @post_path = '/sessions/popup_create'
    redirect_if_already_signed_in(:popup_close)
  end

  def popup_create
    set_cookie_and_redirect(:popup_close, :popup_new)
  end

  def popup_close
  end

  def create
    set_cookie_and_redirect(login_url, :new)
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to login_url, notice: "Logged out!"
  end

  private

  def set_cookie_and_redirect(redirect_url, fail_render_action)
    customer = Customer.find_by_email(params[:email])
    if customer && customer.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = customer.auth_token
      else
        cookies[:auth_token] = customer.auth_token
      end
      redirect_to redirect_url, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
      render fail_render_action
    end
  end

  def redirect_if_already_signed_in(path)
    if current_customer
      redirect_to path
    end
  end
end
