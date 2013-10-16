class WidgetApi::FeaturesController < ApplicationController
  before_action :set_feature, only: [:show, :edit, :update, :destroy]

  def index
    @features = Feature.features_in_group(params[:token]).includes(:comments).order("votes_count DESC")
    respond_to do |format|
      format.html # @features
      format.json
    end
  end

  def show
  end

  def new
    @feature = Feature.new
  end

  def edit
  end

  def create
    @feature = Feature.new(feature_params)
    application = Application.find_by_token(params[:token])
    if params[:user]
      user_params[:application_id] = application.id
      creator = application.users.find_by(email: user_params[:email])
      if creator
        creator.verify_attributes(user_params)
      else
        creator = application.users.create(user_params)
      end
    elsif params[:customer]
      creator = application.customers.find_by(email: params[:customer][:email])
    else
      raise "No valid creator (user/customer) passed in"
    end

    @feature.application = application
    @feature.feature_group_id = application.feature_group.id
    @feature.creator = creator

    respond_to do |format|
      if @feature.save
        format.json { render action: 'show', status: :created }
      else
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @feature.update(feature_params)
        format.html { redirect_to @feature, notice: 'Feature was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feature.destroy
    respond_to do |format|
      format.html { redirect_to features_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feature
      @feature = Feature.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feature_params
      params.require(:feature).permit(:title, :description)
    end

    def user_params
      params.require(:user).permit(:email, :name)
    end
end
