module CurrentCustomer
  def current_customer
    @current_customer ||= Customer.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token] && cookies[:auth_token].length > 1
  end
end
