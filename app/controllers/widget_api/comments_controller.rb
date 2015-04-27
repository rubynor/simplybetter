class WidgetApi::CommentsController < ApplicationController
  include CreatorFinder

  before_action :set_idea, only: [:index, :create, :update]

  def index
    @comments = @idea.comments
    @comments = @comments.visible unless current_customer
  end

  def update
    # TODO: Check auth
    @comment = @idea.comments.find(params[:id])
    if @comment.update_attributes!(comment_attributes)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def create
    # Early exit if no user..
    if params[:user_email].blank?
      render json: 'You must be signed in to comment', status: :unauthorized and return
    end
    app = @idea.application
    @comment = Comment.new(comment_attributes)
    @comment.creator = creator(app, params[:user_email]) # From module
    if @comment.save_and_notify!
      render 'widget_api/comments/show'
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_attributes
    params.require(:comment).permit(:body, :idea_id, :user_email, :customer_email, :visible)
  end

  def set_idea
    @idea ||= Idea.find(params[:idea_id])
  end
end
