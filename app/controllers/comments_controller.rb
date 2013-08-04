class CommentsController < ApplicationController

  def create
    #TODO: add support for customer to add comments
    user_email = params[:comment].delete(:user_email)
    customer_email = params[:comment].delete(:customer_email)
    feature = Feature.find(params[:feature_id])

    if user_email
      creator = User.find_by(email: user_email)
    elsif customer_email
      creator = User.find_by(email: customer_email)
    end
    @comment = Comment.new(comment_attributes)
    @comment.creator = creator
    if @comment.save!
      redirect_to feature_path(@comment.feature)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy!
      redirect_to feature_path(@comment.feature.id)
    end
  end

  private

  def comment_attributes
    params.require(:comment).permit(:body, :feature_id, :user_email, :customer_email)
  end
end