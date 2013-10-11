class FeaturesController < ApplicationController
  before_action :set_application, only: [:add_to_group, :remove_from_group, :update, :destroy, :new, :create]
  before_action :set_feature, except: [:new, :create]

  def new
    @feature = Feature.new
  end

  def create
    @feature = Feature.new(feature_attributes)
    @feature.application = @application
    @feature.creator = current_customer
    respond_to do |format|
      if @feature.save
        format.html { redirect_to new_application_feature_path(@application.id), notice: 'Feature request was successfully created.' }
      else
        format.html { render action: :edit }
      end
    end
  end

  def edit
  end

  def update
    @feature.update_attributes!(feature_attributes)
    redirect_to administrate_group_application_path(@application.id), notice: 'Feature request was updated'
  end

  def destroy
    @feature.destroy!
    redirect_to administrate_group_application_path(@application.id), notice: 'Feature request was removed'
  end

  def add_to_group
    @feature.feature_group = @application.feature_group
    respond_to_js
  end

  def remove_from_group
    @feature.feature_group_id = nil
    respond_to_js
  end

  private

  def feature_attributes
    params.require(:feature).permit(:application_id, :title, :description, :id)
  end

  def set_application
    @application ||= current_customer.applications.find(params[:application_id]) if params[:application_id]
  end

  def set_feature
    @feature ||= set_application.features.find(params[:id])
  end

  def respond_to_js
    respond_to do |format|
      if @feature.save!
        format.js { @feature }
      end
    end
  end
end