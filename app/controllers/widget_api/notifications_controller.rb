class WidgetApi::NotificationsController < ApplicationController
  include CreatorFinder
  before_filter :application

  def index
    puts 'params following..'
    puts params
    user_email = params[:user_email]
    recipient = get_current_user(@application, user_email)
    @notifications = Notification.for(recipient, @application.id)
  end

  def update
    @notification = Notification.find_by(id: notification_attributes[:id])
    @notification.update_attributes(notification_attributes)
    render 'widget_api/notifications/show'
  end

  def count
    render json: {count: index.where(checked: nil).count}
  end

  private

    def notification_attributes
      params.require(:notification).permit(:id, :checked)
    end

    def application
      @application ||= Application.find_by(token: params[:token]) if params[:token]
    end
end
