module CreatorFinder
  def creator(application, creator_email)
    customer = application.customer
    user = User.find_by(email: creator_email)
    if customer.email == creator_email
      creator = customer
    elsif user
      creator = user
    else
      raise "This user does not exist"
    end
  end
end
