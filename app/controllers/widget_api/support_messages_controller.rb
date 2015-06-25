class WidgetApi::SupportMessagesController < WidgetController
  include CreatorFinder

  respond_to :json
  def create
    support_message = SupportMessage.new(support_params.merge({
      application_id: current_application.id,
      user: widget_user
    }))
    if support_message.save_and_send
      render json: {message: support_message.message, status: :created}
    else
      raise "Support Message sending failed: #{support_message.inspect}, errors #{support_message.errors.inspect}"
    end
  end

  def support_params
    params.require(:support_message).permit(:message)
  end
end
