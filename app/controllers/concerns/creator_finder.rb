class NoUserException < StandardError
end

class NoAccessException < StandardError
end

module CreatorFinder
  def get_current_user(application, user_email)
    fail ArgumentError, 'Missing application' unless application
    @current_user ||= creator(application, user_email)
  end

  def creator(application, creator_email)
    fail NoUserException, 'No email provided' unless creator_email
    if (a_customer = Customer.find_by(email: creator_email))
      return a_customer if a_customer.widgets.include?(application)
      fail NoAccessException, 'The customer does not have access to this application'
    end

    if (user = User.find_by(email: creator_email))
      return user if user.widgets.include? application
      fail NoAccessException, 'The user does not have access to this application'
    end

    fail NoUserException, 'This user does not exist'
  end
end
