class NoUserException < StandardError
end

class NoAccessException < StandardError
end

module CreatorFinder

  def current_user
    #TODO: OMA: We should always use the same user param, for simplicity. Convention :)
    get_current_user(current_application, params[:user_email] || params[:email])
  end


  def current_application
    @application ||= Application.find_by!(token: params[:token] || params[:appkey])
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

  private

  def get_current_user(application, user_email)
    fail ArgumentError, 'Missing application' unless application
    @current_user ||= creator(application, user_email)
  end

end
