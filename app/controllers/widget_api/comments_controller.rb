class WidgetApi::CommentsController < ApplicationController
  include CreatorFinder
  before_action :set_idea, only: [:index, :show, :create]

  def index
    @comments = @idea.comments
  end

  def show
    @comment = @idea.comments.find(params[:id])
  end

  def create
    user_email = params[:comment].delete(:user_email)
    customer_email = params[:comment].delete(:customer_email)
    app = @idea.application

    @comment = Comment.new(comment_attributes)
    @comment.creator = creator(app,params[:user][:email])#From module
    if @comment.save
      @comment.subscribe
      @comment.notify
    end
    render 'widget_api/comments/show'
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
end
