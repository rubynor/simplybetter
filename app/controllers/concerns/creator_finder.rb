class NoUserException < StandardError
end

module CreatorFinder
  def get_current_user(application, user_email)
    if application && user_email
      @current_user ||= creator(application, user_email)
    else
      fail ArgumentError, "Missing one of the arguments application: #{application}, or user_email: #{user_email}"
    end
  end

  def creator(application, creator_email)
    a_customer = Customer.find_by(email: creator_email)
    return a_customer if a_customer
    user = User.find_by(email: creator_email)
    return user if user
    raise NoUserException, 'This user does not exist'
  end
end
