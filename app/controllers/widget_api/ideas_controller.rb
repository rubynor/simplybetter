class WidgetApi::IdeasController < ApplicationController
  include CreatorFinder
  before_action :set_idea, only: [:show, :update, :destroy]

  def index
    app = application
    @ideas = app.ideas.visible.includes(:comments).includes(:votes).order("votes_count DESC")
    get_current_user(application, params[:user_email])
  rescue NoUserException
    #It's ok if the user is not logged in
  end

  def show
    get_current_user(application, params[:user_email])
  rescue NoUserException
    #It's ok if the user is not logged in
  end

  def find_similar
    current_application = application
    conditions = { application_id: current_application.id, visible: true }
    @ideas = Idea.search(params[:query], where: conditions, limit: 4, misspellings: { distance: 2 }, partial: true)
    render template: 'ideas/index'
  end

  def create
    @idea = Idea.new(idea_params)
    app = application

    @idea.application = app
    @idea.creator = creator(app, params[:user][:email])#From module

    respond_to do |format|
      if @idea.save
        @idea.notify_customers
        @idea.subscribe
        AdminNotifier.send_to_group(application.customers, @idea.creator, @idea)
        format.json { render action: 'show', status: :created }
      else
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # TODO: require user email, and check if user is owner
    respond_to do |format|
      if @idea.update(idea_params)
        format.json { head :no_content }
      else
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @idea.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:title, :description)
    end

    def application
      @application ||= Application.find_by(token: params[:token]) if params[:token]
    end
end
