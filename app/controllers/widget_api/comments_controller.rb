class WidgetApi::CommentsController < ApplicationController
  before_action :set_feature, only: [:index, :show]

  def index
    @comments = @feature.comments
  end

  def show
    @comment = @feature.comments.find(params[:id])
  end

  def create
    #TODO: add support for customer to add comments
    user_email = params[:comment].delete(:user_email)
    customer_email = params[:comment].delete(:customer_email)
    feature = Feature.find(params[:feature_id])

    creator = User.find_by(email: params[:user][:email])
    unless creator
      creator = Customer.find_by(email: params[:user][:email])
    end
    @comment = Comment.new(comment_attributes)
    @comment.creator = creator
    @comment.save!

    respond_to do |format|
      format.html { redirect_to application_feature_path(@comment.feature) }
      format.json { render 'widget_api/comments/show' }
    end
  end

  def destroy
    # security issue
    # must exchange an expiring usertoken or something to fix
    # TODO: add check for current_user and delete only if params[:user_id] is current_user
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html { redirect_to application_feature_path(@comment.feature.id) }
      format.json { render :json => {
          :feature => @comment.feature.to_json
      }, :callback => params[:callback] || 'feature' }
    end
  end

  private

  def comment_attributes
    params.require(:comment).permit(:body, :feature_id, :user_email, :customer_email)
  end

  def set_feature
    @feature ||= Feature.find(params[:feature_id])
  end
end
