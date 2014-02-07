class IdeasController < ApplicationController
  before_action :set_application, only: [:add_to_group, :remove_from_group, :update, :destroy, :new, :create]
  before_action :set_idea, except: [:new, :create]

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_attributes)
    @idea.application = @application
    @idea.creator = current_customer
    respond_to do |format|
      if @idea.save
        format.html { redirect_to new_application_idea_path(@application.id), notice: 'Idea was successfully created.' }
      else
        format.html { render action: :edit }
      end
    end
  end

  def edit
  end

  def update
    @idea.update_attributes!(idea_attributes)
    redirect_to administrate_group_application_path(@application.id), notice: 'Idea was updated'
  end

  def destroy
    @idea.destroy!
    redirect_to administrate_group_application_path(@application.id), notice: 'Idea was removed'
  end

  def add_to_group
    @idea.idea_group = @application.idea_group
    respond_to_js
  end

  def remove_from_group
    @idea.idea_group_id = nil
    respond_to_js
  end

  private

  def idea_attributes
    params.require(:idea).permit(:application_id, :title, :description, :id)
  end

  def set_application
    @application ||= current_customer.applications.find(params[:application_id]) if params[:application_id]
  end

  def set_idea
    @idea ||= set_application.ideas.find(params[:id])
  end

  def respond_to_js
    respond_to do |format|
      if @idea.save!
        format.js { @idea }
      end
    end
  end
end
