class WidgetApi::SupportMessagesController < ApplicationController
  include CreatorFinder

  respond_to :json
  def create

    message = params[:support_message]
    puts "YAAY", message
    render json: {message: message, status: :created}
  end

  def support_params
    params.require(:support_message).permit(:app_id, )
  end
end
