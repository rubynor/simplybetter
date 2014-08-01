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
    # TODO: Refactor.. this looks kinda messy.. byt trying to exit as early as possible
    # TODO: and not having to do to many db lookups
    a_customer = Customer.find_by(email: creator_email)
    if a_customer
      return a_customer if a_customer.widgets.include?(application)
      raise 'The customer does not have access to this application'
    end

    user = User.find_by(email: creator_email)
    if user
      return user if user.widgets.include? application
      raise 'The user does not have access to this application'
    end

    raise NoUserException, 'This user does not exist'
  end

end
