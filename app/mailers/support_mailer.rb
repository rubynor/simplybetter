class SupportMailer < ActionMailer::Base
  default from: 'noreply@simplybetter.io'
  def send_to_support(support_message)
    # We have to use simplybetter.io as from, otherwise
    # AWS won't send it..
    mail to: support_message.to,
         reply_to: support_message.from,
         subject: "#{support_message.app_name} - Support message from #{support_message.name_or_email}",
         body: support_message.message
  end
end

