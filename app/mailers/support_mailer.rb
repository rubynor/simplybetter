class SupportMailer < ActionMailer::Base
  default from: 'noreply@simplybetter.io'
  def send_to_support(support_message)
    #Will the email be marked as spam/unsafe if we set the user as from, and not a verified simplybetter address?
    mail to: support_message.to, from: support_message.from, reply_to: support_message.from, subject: "#{support_message.app_name} - Support message from #{support_message.name_or_email}", body: support_message.message
  end
end

