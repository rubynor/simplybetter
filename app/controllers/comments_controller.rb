class CommentsController < ApplicationController

  def create
    #TODO: add support for customer to add comments
    @comment = Comment.new(comment_attributes)
    @comment.creator = User.find_by(email: params[:user_id])
    if @comment.save!
      redirect_to feature_path(@comment.feature)
    end
  end

  def destroy
    #TODO: add check for current_user and delete only if params[:user_id] is current_user
    @comment = Comment.find(params[:id])

    if @comment.destroy!
      redirect_to feature_path(@comment.feature.id)
    end
  end

  private

  def comment_attributes
    params.permit(:body, :feature_id)
  end
end