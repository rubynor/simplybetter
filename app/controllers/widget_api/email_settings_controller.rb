class WidgetApi::EmailSettingsController < ApplicationController
  include CreatorFinder

  before_action :set_user
  before_action :find_or_create_email_settings

  def show
  end

  def update
    @settings.update_attributes!(setting_params)
  end

  private

  def set_user
    get_current_user(Application.find_by(token: params[:token]), params[:email])
  end

  def find_or_create_email_settings
    raise "Undefined @user variable" if @current_user.blank?
    @settings = EmailSetting.find_or_create(@current_user)
  end

  def setting_params
    params.require(:email_setting).permit(:unsubscribed)
  end
end
