class IdeasController < ApplicationController
  before_filter :authorize
  before_action :set_application, only: [:update, :destroy, :index]
  before_action :set_idea, only: [:update, :destroy]

  def index
    @ideas = @application.ideas
  end

  def update
    if @idea.save_and_notify(idea_attributes, current_customer)
      render template: 'ideas/show'
    else
      render json: @idea.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @idea.destroy!
    render json: { message: 'success' }
  end

  private

  def idea_attributes
    params.require(:idea).permit(:application_id, :title, :description, :id, :creator, :idea_group_id, :completed, :visible)
  end

  def set_application
    @application ||= current_customer.applications.find(params[:application_id]) if params[:application_id]
  end

  def set_idea
    @idea ||= @application.ideas.find(params[:id])
  end

end
