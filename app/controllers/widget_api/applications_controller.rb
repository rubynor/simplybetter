class WidgetApi::ApplicationsController < ApplicationController

  respond_to :json, :html

  def client_js
    expires_in 20.minutes
    app = Application.find_by(token: params[:appkey])
    @icon = app.icon
  end

  def is_admin
    answer = current_customer && current_customer.applications.find_by(token: params[:token])
    render json: { is_admin: !!answer }.to_json
  end
end
