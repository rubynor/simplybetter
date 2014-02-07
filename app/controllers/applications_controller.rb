class ApplicationsController < ApplicationController
  before_action :set_application, only: [:index, :show, :administrate_group, :update]

  def index
    @applications = current_customer.applications.includes(ideas: :comments)
    @application = Application.new
  end

  def show
  end

  def update
    @application.update_attributes!(application_attributes)
    redirect_to :back, notice: 'Updated!'
  end

  def create
    application = current_customer.applications.create!(application_attributes)
    redirect_to application_path(application.id), notice: 'Application successfully created!'
  end

  def administrate_group
    @ideas = @application.ideas_not_in_group
    @idea_group = @application.idea_group.ideas
  end

  private

  def set_application
    @application ||= current_customer.applications.find(params[:id]) if params[:id]
  end

  def application_attributes
    params.require(:application).permit(:name, :intro)
  end
end
