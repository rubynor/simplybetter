class WidgetController < ApplicationController
  after_action :allow_iframe

  def widget
    @appkey = params[:appkey]
    @email = params[:email]
    @name = params[:name]
    create_user unless @email.blank?
    render template: 'layouts/widget', layout: false
  end

  private

  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end

  def create_user
    customer = Customer.find_by(email: params[:email])
    return if customer # No need to do more lookups if customer found
    user = User.find_by(email: params[:email])
    return if user # No need to do more lookups if user found

    app = Application.find_by(token: params[:appkey])
    app.users.create(email: params[:email], name: params[:name])
  end
end
