class WidgetApi::ApplicationsController < ApplicationController

  def client_js
    expires_in 20.minutes
    app = Application.find_by(token: params[:appkey])
    @icon = app.icon
  end
end
