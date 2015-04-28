class CommentsController < ApplicationController
  before_action :authorize

  def update
    comment = Comment.find(params[:id])
    app = comment.application
    if current_customer.applications.include?(app) && comment.update(comment_params)
      render json: comment, status: :ok
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:visible)
  end
end
