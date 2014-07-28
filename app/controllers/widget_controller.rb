class WidgetController < ApplicationController
  after_action :allow_iframe

  def widget
    @appkey = params[:appkey]
    @email = params[:email]
    @name = params[:name]
    create_user if @email
    render template: 'layouts/widget', layout: false
  end

  private

  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end

  def create_user
    customer = Customer.find_by(email: params[:email])
    user = User.find_by(email: params[:email])
    application_id = Application.find_by(token: params[:appkey]).id

    unless customer || user
      User.create(email: params[:email], name: params[:name], application_id: application_id)
    end
  end
end
