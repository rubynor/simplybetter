class CommentsController < ApplicationController


  def create
    @comment = Comment.new(comment_attributes)
    if @comment.save!
      redirect_to feature_path(@comment.feature)
    end
  end

  def index
    f = Feature.find_by(id: params[:feature_id])
    @comments = f.comments
  end

  private

  def comment_attributes
    params.require(:comment).permit(:body, :feature_id, :user_id)
  end
end