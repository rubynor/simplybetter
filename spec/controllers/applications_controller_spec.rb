
require 'spec_helper'

describe ApplicationsController do

  before do
    @application = Application.make!
    session[:customer_id] = @application.customer.id
  end

  describe 'index' do
    it 'should assign variables @applications and @application' do
      get :index
      assigns(:applications).should be_kind_of(ActiveRecord::Relation)
      assigns(:application).should be_an_instance_of(Application)
    end
  end

  describe 'administrate' do
    it 'should assign current application' do
      get :administrate, id: @application.id
      assigns(:application).should be_an_instance_of(Application)
    end
  end

  describe 'create_feature' do
    it 'should create a new feature' do
      expect {
      post :create_feature, feature: {title: 'The new feature', description: 'long description'}, id: @application.id
      }.to change{Feature.all.count}.by(1)
    end
    it 'should redirect to application_new_feature_path' do
      post :create_feature, feature: {title: 'The new feature', description: 'long description'}, id: @application.id
      response.should redirect_to(application_new_feature_path(@application.id))
    end
  end

  describe 'create' do
    it 'should create a new application' do
      expect {
        post :create, application: {name: 'The bestest application'}
      }.to change{ Application.all.count }.by(1)
    end
    it 'should redirect to applications_path' do
      post :create, application: {name: 'The bestest application'}
      response.should redirect_to(applications_path)
    end
  end

  describe 'administrate_group' do
    it 'should assign @features, and @feature_group' do
      f = Feature.make!
      f.update_attributes!(feature_group_id: @application.feature_group.id)
      @application.features << Feature.make!(title: 'new feature')
      get :administrate_group, id: @application.id
      assigns(:features).should be_kind_of(ActiveRecord::Relation)
      assigns(:features).first.should be_kind_of(Feature)
      assigns(:feature_group).first.should be_an_instance_of(Feature)
    end
  end

  describe 'add_feature_request_to_group' do
    it 'should add a feature request to applications feature group' do
      f = Feature.make!
      f.update_attributes(application_id: @application.id)
      post :add_feature_request_to_group, id: @application.id, fid: f.id, format: :js
      assigns(:feature).feature_group.should == @application.feature_group
    end
  end

  describe 'remove_feature_request_from_group' do
    it 'should remove a feature request from the feature group' do
      f = Feature.make!
      f.update_attributes(application_id: @application.id)
      f.update_attributes(feature_group_id: @application.feature_group.id)
      delete :remove_feature_request_from_group, id: @application.id, fid: f.id, format: :js
      assigns(:feature).feature_group_id.should be_nil
    end
  end



end