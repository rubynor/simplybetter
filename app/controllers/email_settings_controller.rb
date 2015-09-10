class EmailSettingsController < ApplicationController
  layout 'info'

  def unsubscribe
    @message =
      begin
        EmailSetting.unsubscribe!(params[:unsubscribe_token])
      rescue ArgumentError => e
        "Unfortunately we could not unsubscribe you. Your link might be expired"
      end
  end
end
