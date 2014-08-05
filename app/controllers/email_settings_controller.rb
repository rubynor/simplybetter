class EmailSettingsController < ApplicationController
  layout false

  def unsubscribe
    setting = EmailSetting.find_by(
      unsubscribe_token: params[:unsubscribe_token]
    )
    @message =
      if setting
        if setting.unsubscribed?
          "You are already unsubscribed from email notifications"
        else
          setting.update_attributes!(unsubscribed: true)
          "You have been unsubscribed from email notifications"
        end
      else
        "Unfortunately we could not unsubscribe you. Your link might be expired"
      end
  end
end
