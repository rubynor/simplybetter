class CollaboratorsController < ApplicationController
  before_action :authorize
  before_action :set_application

  def index
    @collaborators = @application.customers
  end

  def destroy
    customer = Customer.find(params[:id])

    if @application.owner == customer
      render json: {errors: ['You cannot remove the application owner']}, status: 400
      return
    end

    if customer == current_customer
      render json: {errors: ['You cannot remove yourself']}, status: 400
      return
    end

    @application.customers.delete(customer)
    render json: {success: 'collaborator removed'}
  end

  def create
    @customer = Customer.find_by(email: params[:email])

    unless @customer
      password = SecureRandom.urlsafe_base64(6)
      @customer = Customer.create!(email: params[:email], name: params[:name], password: password, password_confirmation: password)
    end

    @application.customers << @customer

    if password
      CustomerMailer
        .add_new_collaborator(@customer, password, @application, current_customer)
        .deliver
    else
      CustomerMailer
        .add_collaborator(@customer, @application, current_customer)
        .deliver
    end

    render json: { success: 'user has been added' }
  rescue ActiveRecord::RecordNotUnique
    render json: { errors: ["#{@customer.email} is already a collaborator"] }, status: 409
  rescue ActiveRecord::RecordInvalid
    render json: { errors: @application.errors.full_messages }, status: 400
  end

  private

  def set_application
    @application ||= current_customer.applications.find(params[:application_id])
  end
end
