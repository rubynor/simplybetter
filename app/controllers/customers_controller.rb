class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    customer = Customer.create!(customer_attributes)
    render text: "Your customer token is #{customer.token}"
  end

  private

  def customer_attributes
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end
end
