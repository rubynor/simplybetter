class WidgetApi::SupportMessagesController < ApplicationController
  include CreatorFinder

  respond_to :json
  def create
    message = params[:support_message]
    puts "YAAY", message
    render json: {message: message, status: :created}
  end
end
