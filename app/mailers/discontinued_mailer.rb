class DiscontinuedMailer < ActionMailer::Base
  default from: 'support@simplybetter.io'

  def send_to_all
    subject = 'Simplybetter discontinued'

    mail to: 'support@simplybetter.io', bcc: Customer.all.map(&:email), subject: subject
  end
end
