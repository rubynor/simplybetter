class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :administrate_group,:edit, :update]

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
    @ideas = @application.ideas_not_in_group.includes(:comments)
    @idea_group = @application.idea_group.ideas.includes(:comments)
  end

  private

  def application_attributes
    params.require(:application).permit(:name, :intro, :icon)
  end
end
