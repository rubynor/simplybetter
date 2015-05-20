class ApplicationsController < ApplicationController
  before_action :authorize
  before_action :set_application, only: [:show, :administrate_group, :edit, :update, :preview]

  def index
    if applications.any?
      redirect_to administrate_group_application_path(applications.first.id)
    else
      redirect_to new_application_path
    end
  end
  def new
    @application = Application.new
  end

  def edit
  end

  def show
    @icons = Application.icon.values
  end

  def update
    @application.update_attributes!(application_attributes)
    redirect_to :back, notice: 'Updated!'
  end

  def create
    @application = Application.new(application_attributes)
    @application.customers << current_customer
    if @application.save
      redirect_to application_path(@application.id), notice: 'Application successfully created!'
    else
      render :index
    end
  end

  def administrate_group
  end

  def preview
    @token = @application.token
    @email = current_customer.email
    @name = current_customer.name
  end

  private

  def set_application
    @application ||= current_customer.applications.find(params[:id]) if params[:id]
  rescue
    flash[:error] = "We couldn't find that application, or u don't have rights to that application"
    redirect_to edit_customer_path
  end

  def application_attributes
    params.require(:application).permit(:name, :intro, :icon, :support_enabled, :support_email)
  end
end
