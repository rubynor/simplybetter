class EmailSettingsController < ApplicationController
  layout 'info'

  def unsubscribe
    @message = EmailSetting.unsubscribe!(params[:unsubscribe_token])
  rescue ArgumentError => e
    @message = 'Unfortunately we could not unsubscribe you. Your link might be expired'
    Honeybadger.notify_or_ignore(e)
  end
end
