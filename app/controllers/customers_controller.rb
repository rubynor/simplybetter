class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    customer = Customer.create!(customer_attributes)
    session[:customer_id] = customer.id
    redirect_to features_path
  end

  private

  def customer_attributes
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end
end
