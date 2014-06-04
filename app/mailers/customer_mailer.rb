class CustomerMailer < ActionMailer::Base
  default from: 'noreply@simplybetter.io'

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Password Reset'
  end
end
