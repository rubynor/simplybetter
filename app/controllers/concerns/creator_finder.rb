module CreatorFinder
  def get_current_user(application,user_email)
    if application && user_email
      @current_user ||= creator(application, user_email)
    else
      raise "Missing one of the arguments application: #{application}, or user_email: #{user_email}"
    end
  end

  def creator(application, creator_email)
    customer = application.customer
    a_customer = Customer.find_by(email: creator_email)
    user = User.find_by(email: creator_email)
    if customer.email == creator_email
      return customer
    elsif a_customer
      return a_customer
    elsif user
      return user
    else
      raise "This user does not exist"
    end
  end
end
