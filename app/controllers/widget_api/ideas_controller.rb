class WidgetApi::IdeasController < ApplicationController
  include CreatorFinder
  before_action :set_idea, only: [:show, :update, :destroy]

  def index
    app = application
    @ideas = app.ideas.includes(:comments).includes(:votes).order('votes_count DESC')
    @ideas = @ideas.visible unless current_customer.try { current_customer.admin_for?(app) }
    get_current_user(application, params[:user_email])
  rescue NoUserException
    # It's ok if the user is not logged in
  end

  def show
    get_current_user(application, params[:user_email])
  rescue NoUserException
    # It's ok if the user is not logged in
  end

  def find_similar
    current_application = application
    conditions = { application_id: current_application.id, visible: true }
    @ideas = Idea.search(params[:query], where: conditions, fields: [:title, :description], limit: 4, misspellings: { distance: 2 }, partial: true)
    render template: 'ideas/index'
  end

  def create
    @idea = Idea.new(idea_params)

    respond_to do |format|
      if @idea.widget_save_and_notify(application, creator(application, params[:user_email]))
        format.json { render action: 'show', status: :created }
      else
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    user = get_current_user(application, params[:user_email])
    if @idea.creator != user && !current_customer
      return render json: 'Not owner of idea', status: 403
    end

    if current_customer && @idea.creator != current_customer
      @idea.update!(last_edit_admin: current_customer, last_edit_admin_time: Time.now)
    end

    @idea.update!(idea_params)
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
    if current_customer && current_customer.admin_for?(application)
      params.require(:idea).permit(:title, :description, :completed, :visible)
    else
      params.require(:idea).permit(:title, :description)
    end
  end

  def application
    @application ||= Application.find_by(token: params[:token]) if params[:token]
  end
end
