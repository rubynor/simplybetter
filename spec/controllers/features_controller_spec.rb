require 'spec_helper'
describe IdeasController do
  before do
      @application = Application.make!(customers: [Customer.make!])
      session[:customer_id] = Customer.first.id
  end
  describe 'create' do
    it 'should create a new idea' do
      expect {
      post :create, idea: {title: 'The new idea', description: 'long description'}, application_id: @application.id
      }.to change{Idea.all.count}.by(1)
    end
    it 'should redirect to application_new_idea_path' do
      post :create, idea: {title: 'The new idea', description: 'long description'}, application_id: @application.id
      response.should redirect_to(new_application_idea_path(@application.id))
    end
  end

  describe 'add_to_group' do
    it 'should add a idea request to applications idea group' do
      f = Idea.make!
      f.update_attributes(application_id: @application.id)
      post :add_to_group, application_id: @application.id, id: f.id, format: :js
      assigns(:idea).idea_group.should == @application.idea_group
    end
  end

  describe 'remove_from_group' do
    it 'should remove a idea request from the idea group' do
      f = Idea.make!
      f.update_attributes(application_id: @application.id)
      f.update_attributes(idea_group_id: @application.idea_group.id)
      delete :remove_from_group, application_id: @application.id, id: f.id, format: :js
      assigns(:idea).idea_group_id.should be_nil
    end
  end
end
