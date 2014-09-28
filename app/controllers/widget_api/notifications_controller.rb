class WidgetApi::NotificationsController < ApplicationController
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
    render json: {count: index.where(checked: nil).count}
  rescue NoMethodError
    render json: :no_content
  end

  private

  def notification_attributes
    params.require(:notification).permit(:id, :checked)
  end
end
