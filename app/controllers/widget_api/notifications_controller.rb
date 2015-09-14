class WidgetApi::NotificationsController < WidgetController

  def index
    @notifications = Notification.for(widget_user, current_application.id)
  end

  def update
    @notification = Notification.find_by(id: notification_attributes[:id])
    @notification.update_attributes(notification_attributes)
    render 'widget_api/notifications/show'
  end

  def count
    decode_params unless params[:email].present? && params[:appkey].present?
    user_email = params[:email]
    recipient = Customer.find_by(email: user_email)
    recipient = User.find_by(email: user_email) unless recipient
    notifications = Notification.joins(:application).where(recipient: recipient, applications: {token: params[:appkey], disabled: false}).where(checked: nil)
    render json: { count: notifications.count }
  end

  private

  def notification_attributes
    params.require(:notification).permit(:id, :checked)
  end
end
