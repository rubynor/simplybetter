class CustomersController < ApplicationController
  before_action :authorize, except: [:new, :create]

  def index
    @applications = current_customer.applications.includes(:features)
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_attributes)
    if @customer.save
      session[:customer_id] = customer.id
      redirect_to root_url, notice: "Congratulations! You are now a registered customer of simplybetter.io"
    else
      render action: :new
    end
  end

  def create_application
    current_customer.applications.create!(application_attributes)
    redirect_to action: :index
  end

  private

  def application_attributes
    params.require(:application).permit(:name)
  end

  def customer_attributes
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end

  def authorize
    redirect_to login_path unless current_customer
  end

end
