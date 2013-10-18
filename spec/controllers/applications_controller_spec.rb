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

  describe 'show' do
    it 'should assign @application' do
      get :show, id: @application.id
      assigns(:application).should be_an_instance_of(Application)
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
end
