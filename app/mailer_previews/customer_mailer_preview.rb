class CustomerMailerPreview < ActionMailer::Preview
  def password_reset
    user = Customer.last
    user.password_reset_token = 'hjh'
    CustomerMailer.password_reset(user)
  end

  def add_collaborator
    CustomerMailer.add_collaborator(Customer.last, Application.first, Customer.first)
  end

  def add_new_collaborator
    CustomerMailer.add_new_collaborator(Customer.last, 'asdfadf', Application.first, Customer.first)
  end
end
