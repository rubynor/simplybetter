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
    app = Application.find_by(token: params[:appkey])
    customer = Customer.find_by(email: params[:email])

    if customer
      customer.widgets << app unless customer.widgets.include?(app)
      return # No need to do more lookups if customer found
    end

    user = User.find_by(email: params[:email])

    if user
      user.widgets << app unless user.widgets.include?(app)
      return # No need to do more lookups if user found
    end

    app.users.create(email: params[:email], name: params[:name])
  end
end
