class CommentsController < ApplicationController

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy!
      head :ok
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end
end
