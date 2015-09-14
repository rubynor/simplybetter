class ApplicationsController < ApplicationController
  before_action :authorize
  before_action :set_application, only: [:show_ideas, :installation_instructions, :show, :edit, :update, :preview, :customization, :collaborators, :add_collaborator, :remove_collaborator]

  def index
    if applications.any?
      redirect_to show_ideas_application_path(applications.first.id)
    else
      redirect_to new_application_path
    end
  end

  def new
    @application = Application.new
  end

  def show
  end

  def customization
  end

  def show_ideas
  end

  def installation_instructions
  end

  def collaborators
    @collaborators = @application.customers
  end

  def remove_collaborator
    customer = Customer.find_by(email: params[:email])
    if customer != current_customer
      @application.customers.delete(customer)
      render json: {success: 'collaborator removed'}
    else
      render json: {errors: ['You cannot remove yourself']}, status: 400
    end
  end

  def add_collaborator
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

  def update
    @application.update_attributes!(application_attributes)
  rescue ActiveRecord::RecordInvalid
    render json: { errors: @application.errors.full_messages }, status: 400
  end

  def create
    @application = Application.new(application_attributes)
    @application.owner = current_customer
    @application.customers << current_customer
    if @application.save
      redirect_to customization_application_path(@application.id), notice: 'Application successfully created!'
    else
      render :index
    end
  end

  def preview
    @token = @application.token
    @email = current_customer.email
    @name = current_customer.name
  end

  private

  def set_application
    if params[:id]
      @application ||= current_customer.applications.find(params[:id])
      session[:current_application] = @application.id
    end
  rescue
    flash[:error] = "We couldn't find that application, or you don't have rights to that application"
    redirect_to edit_customer_path
  end

  def application_attributes
    params.require(:application).permit(:name, :intro, :icon, :support_enabled, :support_email, :third_party_support, :faqs_enabled)
  end
end
