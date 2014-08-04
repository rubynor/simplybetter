class CustomerMailerPreview < ActionMailer::Preview
  def password_reset
    user = Customer.last
    user.password_reset_token = 'hjh'
    CustomerMailer.password_reset(user)
  end
end
