class IdeasController < ApplicationController
  before_action :set_application, only: [:add_to_group, :remove_from_group, :update, :destroy, :new, :create, :index]
  before_action :set_idea, except: [:new, :create, :index]

  def index
    if current_customer
      @ideas = @application.ideas
    end
  end

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
    @users = []
    @application.users.map do |u|
      @users.push(push_string(u,"User"))
    end
    @users.push(push_string(@application.customer,"Customer"))
  end

  def update
    attributes = idea_attributes
    creator = attributes.delete(:creator)
    @idea.assign_attributes(attributes)
    @idea.creator = Idea.find_creator(creator)
    if @idea.save
      redirect_to administrate_group_application_path(@application.id), 
        notice: 'Idea was updated'
    else
      render :edit
    end
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
    params.require(:idea).permit(:application_id, :title, :description, :id, :creator)
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

  def push_string(object,model_name)
    ["#{object.name} #{object.email}", "#{model_name},#{object.id}"]
  end
end
