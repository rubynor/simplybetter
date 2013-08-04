class FeaturesController < ApplicationController
  before_action :set_feature, only: [:show, :edit, :update, :destroy]

  # GET /features
  # GET /features.json
  def index
    @features = Feature.includes(:comments).order("votes_count DESC")
    respond_to do |format|
      format.html # @features
      format.js { render :json => @features.to_json( :include => [ :comments => { :include => :creator }, :creator => {}]), :callback => params[:callback] || 'features' }
    end
  end

  # GET /features/1
  # GET /features/1.json
  def show
  end

  # GET /features/new
  def new
    @feature = Feature.new
  end

  # GET /features/1/edit
  def edit
  end

  # POST /features
  # POST /features.json
  def create
    @feature = Feature.new(feature_params)
    application = Application.find_by_token(params[:token])
    if params[:user_id]
      creator = application.users.find_by(email: params[:user][:email])
    elsif params[:customer_id]
      creator = application.customers.find_by(email: params[:creator][:email])
    else
      raise "No valid creator (user/customer) passed in"
    end

    @feature.creator = creator

    respond_to do |format|
      if @feature.save
        format.html { redirect_to @feature, notice: 'Feature was successfully created.' }
        format.json { render action: 'show', status: :created, location: @feature }
      else
        format.html { render action: 'new' }
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /features/1
  # PATCH/PUT /features/1.json
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

  # DELETE /features/1
  # DELETE /features/1.json
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
      params.require(:feature).permit(:title, :description, :application_id)
    end
end
