module CreatorFinder
  def creator(application, creator_email)
    customer = application.customer
    a_customer = Customer.find_by(email: creator_email)
    user = User.find_by(email: creator_email)
    if customer.email == creator_email
      creator = customer
    elsif a_customer
      creator = a_customer
    elsif user
      creator = user
    else
      raise "This user does not exist"
    end
  end
end
