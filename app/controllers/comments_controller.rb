class CommentsController < ApplicationController

  def create
    #TODO: add support for customer to add comments
    @comment = Comment.new(comment_attributes)
    @comment.creator = User.find_or_create_by(email: params[:email], name: params[:name])
    if @comment.save!
    end

    respond_to do |format|
      format.html { redirect_to feature_path(@comment.feature) }
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
      format.html { redirect_to feature_path(@comment.feature.id) }
      format.js { render :json => {
          :feature => @comment.feature.to_json
      }, :callback => params[:callback] || 'feature' }
    end
  end

  private

  def comment_attributes
    params.permit(:body, :feature_id)
  end
end