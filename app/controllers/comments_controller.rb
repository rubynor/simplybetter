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
    end

    respond_to do |format|
      format.html { redirect_to application_feature_path(@comment.feature) }
      format.js { render :json => {
          :feature => @comment.feature.to_json
      }, :callback => params[:callback] || 'feature' }
    end
  end

  def destroy
    # security issue
    # must exchange an expiring usertoken or something to fix
    # TODO: add check for current_user and delete only if params[:user_id] is current_user
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html { redirect_to application_feature_path(@comment.feature.id) }
      format.js { render :json => {
          :feature => @comment.feature.to_json
      }, :callback => params[:callback] || 'feature' }
    end
  end

  private

  def comment_attributes
    params.require(:comment).permit(:body, :feature_id, :user_email, :customer_email)
  end
end
