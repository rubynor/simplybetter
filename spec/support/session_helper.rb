module SessionHelper

  def sign_in_customer(customer)
    cookies[:auth_token] = customer.auth_token
  end

  def encode_to_base64(appkey, email, name)
    Base64.encode64("?appkey=#{appkey}&email=#{email}&name=#{name}")
  end
end
