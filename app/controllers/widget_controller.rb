class WidgetController < ApplicationController
  after_action :allow_iframe

  def widget
    @appkey = params[:appkey]
    @email = params[:email]
    @name = params[:name]
    render template: 'layouts/widget', layout: false
  end

  private

  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end
end