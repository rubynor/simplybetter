class ContactFormMailer < ActionMailer::Base

  SUPPORT_EMAIL = 'support@simplybetter.io'

  def contact_us(name:, email:, message:)
    @message = message
    mail to: SUPPORT_EMAIL, from: SUPPORT_EMAIL, reply_to: email, subject: "#{name} - support message from Simplybetter.io"
  end

end
