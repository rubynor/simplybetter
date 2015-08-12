class ContactFormMailer < ActionMailer::Base

  SUPPORT_EMAIL = 'support@simplybetter.io'

  def contact_us(name:, email:, message:)
    @message = message
    mail to: SUPPORT_EMAIL, from: email.downcase, subject: "#{name} - support message from Simplybetter.io"
  end

end
