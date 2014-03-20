class WidgetApi::IdeasController < ApplicationController
  include CreatorFinder
  before_action :set_idea, only: [:show, :edit, :update, :destroy]

  def index
    app = Application.find_by(token: params[:token])
    @ideas = app.ideas.visible.includes(:comments).includes(:votes).order("votes_count DESC")
    begin
      get_current_user(application,params[:user_email])
    rescue Exception => msg
      #It's ok if the user is not logged in
    end
  end

  def show
    begin
      get_current_user(application,params[:user_email])
    rescue Exception => msg
    end
  end

  def new
    @idea = Idea.new
  end

  def edit
  end

  def find_similar
    current_application = Application.find_by(token: params[:application_id])
    conditions = {application_id: current_application.id, visible: true}
    render json: Idea.search(params[:query],where: conditions, limit: 4, misspellings: {distance: 2}, partial: true)
  end

  def create
    @idea = Idea.new(idea_params)
    application = Application.find_by_token(params[:token])

    @idea.application = application
    @idea.creator = creator(application,params[:user][:email])#From module

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
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url }
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

    def user_params
      params.require(:user).permit(:email, :name)
    end

    def application
      @application ||= Application.find_by(token: params[:token]) if params[:token]
    end
end
