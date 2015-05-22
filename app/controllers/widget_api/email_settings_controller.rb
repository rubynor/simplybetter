class WidgetApi::EmailSettingsController < WidgetController
  before_action :find_or_create_email_settings

  def show
  end

  def update
    @settings.update_attributes!(setting_params)
  end

  private

  def find_or_create_email_settings
    raise "Undefined @user variable" if current_user.blank?
    @settings = EmailSetting.find_by(mailable: current_user)
  end

  def setting_params
    params.require(:email_setting).permit(:unsubscribed)
  end
end
