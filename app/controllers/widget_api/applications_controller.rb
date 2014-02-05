class WidgetApi::ApplicationsController < ApplicationController
  def show
    app = Application.find_by(token: params[:id])
    if app
      render json: {name: app.name, intro: app.intro}
    else
      render json: {error: "Can't find your app based on that app-id"}, status: 500
    end
  end
end
