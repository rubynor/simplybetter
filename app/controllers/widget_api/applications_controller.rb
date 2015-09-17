class WidgetApi::ApplicationsController < ApplicationController
  protect_from_forgery except: :client_js
  respond_to :json, :html

  def client_js
    expires_in 20.minutes
    if (app = Application.active.find_by(token: params[:appkey]))
      @icon = app.icon
    else
      @error = "Could not find application with appkey #{params[:appkey]}"
    end
  end

  def is_admin
    answer = current_customer && current_customer.applications.active.find_by(token: params[:token])
    render json: { is_admin: !!answer }.to_json
  end
end
