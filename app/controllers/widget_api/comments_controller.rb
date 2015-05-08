class WidgetApi::CommentsController < ApplicationController
  include DecodeParams
  include CreatorFinder

  before_action :set_idea, only: [:index, :create, :update]

  def index
    @comments = @idea.comments
    @comments = @comments.visible unless current_customer
  end

  def update
    @comment = @idea.comments.find(params[:id])

    unless current_customer
      user = get_current_user(@comment.application, params[:email])
      return render json: 'error', status: 403 unless @comment.creator == user
    end

    if @comment.update_attributes!(comment_attributes)
      render json: @comment
    end
  end

  def create
    # Early exit if no user..
    if params[:email].blank?
      render json: 'You must be signed in to comment', status: :unauthorized and return
    end
    app = @idea.application
    @comment = Comment.new(comment_attributes)
    @comment.creator = creator(app, params[:email]) # From module
    if @comment.save_and_notify!
      render 'widget_api/comments/show'
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_attributes
    if current_customer
      params.require(:comment).permit(:body, :idea_id, :visible)
    else
      params.require(:comment).permit(:body, :idea_id)
    end
  end

  def set_idea
    @idea ||= Idea.find(params[:idea_id])
  end
end
