module SessionHelper

  def sign_in_customer(customer)
    cookies[:auth_token] = customer.auth_token
  end

  def login_as(customer)
    visit login_path
    fill_in 'email', with: customer.email
    fill_in 'password', with: 'dev'
    click_button 'LOG ME IN'
  end

  def default_customer
    Customer.find_by(email: 'lol@lol.com')
  end

  def login_as_customer
    login_as default_customer
  end

  def encode_to_base64(appkey, email, name)
    Base64.encode64("?appkey=#{appkey}&email=#{email}&name=#{name}")
  end
end
