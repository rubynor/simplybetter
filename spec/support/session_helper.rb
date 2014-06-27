module SessionHelper

  def sign_in_customer(customer)
    cookies[:auth_token] = customer.auth_token
  end
end
