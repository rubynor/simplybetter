class CustomerMailer < ActionMailer::Base
  default from: 'support@simplybetter.io'

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Password Reset'
  end

  def invite(customer)
    mail to: customer.email, subject: 'You have been added to a team'
  end

  def invite_new_customer(customer, password)
    mail to: customer.email, subject: 'You have been added to a team'
  end
end
