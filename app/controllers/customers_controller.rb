class CustomersController < ApplicationController
  before_action :authorize, except: [:new, :create]
  before_action :set_application, only: [:edit, :update, :edit_unsafe, :update_unsafe]
  layout "splash_screen", except: [:edit, :update, :edit_unsafe, :update_unsafe]

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_attributes)
    if @customer.save
      session[:customer_id] = @customer.id
      redirect_to root_path, notice: "Congratulations! You are now a registered customer of simplybetter.io"
    else
      render action: :new
    end
  end

  def edit
  end

  def edit_unsafe
  end

  def update
    current_customer.update_attributes!(safe_attributes)
    redirect_to :back, notice: 'Profile updated!'
  end

  def update_unsafe
    attributes = unsafe_attributes
    if current_customer.authenticate(attributes.delete(:current_password))
      if current_customer.update_attributes(attributes)
        redirect_to edit_unsafe_customer_path(current_customer.id), notice: 'Profile updated!'
      else
        render :edit_unsafe
      end
    else
      flash[:error] = 'Validation failed. Current password was incorrect'
      redirect_to :back
    end
  end

  private

  def application_attributes
    params.require(:application).permit(:name)
  end

  def customer_attributes
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end

  def safe_attributes
    params.require(:customer).permit(:name)
  end

  def unsafe_attributes
    params.require(:customer).permit(:email, :password, :password_confirmation, :current_password)
  end

  def authorize
    redirect_to login_path unless current_customer
  end

  def set_application
    if params[:application_id]
      @application ||= current_customer.applications.find(params[:application_id])
    else
      @application ||= Application.new
    end
  end

end
