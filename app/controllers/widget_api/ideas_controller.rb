class WidgetApi::IdeasController < WidgetController
  before_action :set_idea, only: [:show, :update, :destroy]

  def index
    app = current_application
    @ideas = app.ideas.includes(:comments).includes(:votes).order('votes_count DESC')
    @ideas = @ideas.visible unless current_customer.try { current_customer.admin_for?(app) }
    widget_user
  end

  def show
    widget_user
  end

  def find_similar
    conditions = { application_id: current_application.id, visible: true }
    @ideas = Idea.search(params[:query], where: conditions, fields: [:title, :description], limit: 4, misspellings: { distance: 2 }, partial: true)
    render template: 'ideas/index'
  end

  def create
    @idea = Idea.new(idea_params)

    respond_to do |format|
      if @idea.widget_save_and_notify(current_application, widget_user)
        format.json { render action: 'show', status: :created }
      else
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @idea.creator != widget_user && !current_customer
      return render json: 'Not owner of idea', status: 403
    end

    if current_customer && @idea.creator != current_customer
      if @idea.should_set_last_edit_admin?(idea_params)
        @idea.assign_attributes(last_edit_admin: current_customer, last_edit_admin_time: Time.now)
      end
    end

    @idea.assign_attributes(idea_params)
    @idea.save!
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
    #TODO: OMA: unsafe. use scope. current_user.ideas.find
    @idea = Idea.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def idea_params
    if current_customer && current_customer.admin_for?(current_application)
      params.require(:idea).permit(:title, :description, :completed, :visible)
    else
      params.require(:idea).permit(:title, :description)
    end
  end
end
