class WidgetController < ApplicationController

  def widget
    @appkey = params[:appkey]
    @email = params[:email]
    @name = params[:name]
    render template: 'layouts/widget', layout: false
  end
end