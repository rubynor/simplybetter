class CommentsController < ApplicationController


  def create
    @comment = Comment.new(comment_attributes)
    if @comment.save!
      redirect_to feature_path(@comment.feature)
    end
  end

  private

  def comment_attributes
    params.permit(:body, :feature_id, :user_id)
  end
end