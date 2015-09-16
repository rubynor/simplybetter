class CustomerMailer < ActionMailer::Base
  default from: 'support@simplybetter.io'

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Password Reset'
  end

  def add_collaborator(customer, application, current_customer)
    @customer = customer
    @application = application
    @current_customer = current_customer
    mail to: customer.email, subject: 'You have been added to a team'
  end

  def add_new_collaborator(customer, password, application, current_customer)
    @customer = customer
    @password = password
    @application = application
    @current_customer = current_customer
    mail to: customer.email, subject: 'You have been added to a team'
  end
end
