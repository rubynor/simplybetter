class WidgetApi::CommentsController < ApplicationController
  include CreatorFinder
  include AbuseReportAction
  before_action :set_idea, only: [:index, :show, :create]
  report_abuse_action model: Comment, app: :application, user_param: :user_email

  def index
    @comments = @idea.comments.visible
  end

  def show
    @comment = @idea.comments.visible.find(params[:id])
  end

  def create
    # Early exit if no user..
    if params[:user_email].blank?
      render json: 'You must be signed in to comment', status: :unauthorized and return
    end
    app = @idea.application
    @comment = Comment.new(comment_attributes)
    @comment.creator = creator(app, params[:user_email])#From module
    if @comment.save_and_notify!
      render 'widget_api/comments/show'
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # TODO: add check for current_user and delete only if params[:user_id] is current_user
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html { redirect_to application_idea_path(@comment.idea.id) }
      format.json { render :json => {
          :idea => @comment.idea.to_json
      }, :callback => params[:callback] || 'idea' }
    end
  end

  private

  def comment_attributes
    params.require(:comment).permit(:body, :idea_id, :user_email, :customer_email)
  end

  def set_idea
    @idea ||= Idea.find(params[:idea_id])
  end

  def application
    set_idea.application
  end
end
