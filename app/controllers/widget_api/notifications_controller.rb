class WidgetApi::NotificationsController < ApplicationController
  include CreatorFinder
  before_filter :application

  def index
    user_email = params[:user_email]
    recipient = get_current_user(@application, user_email)
    @notifications = Notification.for(recipient, @application.id)
  rescue NoAccessException
    # No problem if no user
  end

  def update
    @notification = Notification.find_by(id: notification_attributes[:id])
    @notification.update_attributes(notification_attributes)
    render 'widget_api/notifications/show'
  end

  def count
    user_email = params[:user_email]
    recipient_id = Customer.find_by(email: user_email).try(:id)
    recipient_id = User.find_by(email: user_email).try(:id) unless recipient_id
    notifications = Notification.joins(:application).where(recipient_id: recipient_id, applications: {token: params[:token]}).where(checked: nil)
    render json: { count: notifications.count }
  end

  private

    def notification_attributes
      params.require(:notification).permit(:id, :checked)
    end

    def application
      @application ||= Application.find_by(token: params[:token]) if params[:token]
    end
end
