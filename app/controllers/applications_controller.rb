class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :administrate_group,:edit, :update]

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
    @application = current_customer.applications.new(application_attributes)
    if @application.save
      redirect_to application_path(@application.id), notice: 'Application successfully created!'
    else
      render :index
    end
  end

  def administrate_group
    @ideas = @application.ideas_not_in_group.includes(:comments)
    @idea_group = @application.idea_group.ideas.includes(:comments)
  end

  private

  def set_application
    @application ||= current_customer.applications.find(params[:id]) if params[:id]
  end

  def application_attributes
    params.require(:application).permit(:name, :intro, :icon)
  end
end
