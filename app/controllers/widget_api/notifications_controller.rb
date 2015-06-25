class WidgetApi::NotificationsController < WidgetController
  include CreatorFinder

  def index
    @notifications = Notification.for(current_user, current_application.id)
  rescue NoAccessException
    # No problem if no user
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
    notifications = Notification.joins(:application).where(recipient: recipient, applications: {token: params[:appkey]}).where(checked: nil)
    render json: { count: notifications.count }
  rescue NoAccessException
    # No problem if no user
  end

  private

  def notification_attributes
    params.require(:notification).permit(:id, :checked)
  end
end
