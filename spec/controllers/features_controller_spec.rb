require 'spec_helper'
describe FeaturesController do
  before do
      @application = Application.make!
      session[:customer_id] = Customer.first.id
  end
  describe 'create' do
    it 'should create a new feature' do
      expect {
      post :create, feature: {title: 'The new feature', description: 'long description'}, application_id: @application.id
      }.to change{Feature.all.count}.by(1)
    end
    it 'should redirect to application_new_feature_path' do
      post :create, feature: {title: 'The new feature', description: 'long description'}, application_id: @application.id
      response.should redirect_to(new_application_feature_path(@application.id))
    end
  end

  describe 'add_to_group' do
    it 'should add a feature request to applications feature group' do
      f = Feature.make!
      f.update_attributes(application_id: @application.id)
      post :add_to_group, application_id: @application.id, id: f.id, format: :js
      assigns(:feature).feature_group.should == @application.feature_group
    end
  end

  describe 'remove_from_group' do
    it 'should remove a feature request from the feature group' do
      f = Feature.make!
      f.update_attributes(application_id: @application.id)
      f.update_attributes(feature_group_id: @application.feature_group.id)
      delete :remove_from_group, application_id: @application.id, id: f.id, format: :js
      assigns(:feature).feature_group_id.should be_nil
    end
  end
end
