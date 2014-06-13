require 'spec_helper'

describe ApplicationsController do

  before do
    @customer = Customer.make!
    @application = Application.make!(customers: [@customer])
    session[:customer_id] = @application.customers.first.id
  end

  describe 'index' do
    it 'should assign variables @applications and @application' do
      get :index
      assigns(:applications).first.should be_kind_of(Application)
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
      response.should redirect_to(application_path(Application.last.id))
    end
  end

  describe 'administrate_group' do
    # TODO: Pål.. fix or remove
    pending 'should assign @ideas, and @idea_group' do
      f = Idea.make!
      f.update_attributes!(idea_group_id: @application.idea_group.id)
      @application.ideas << Idea.make!(title: 'new idea')
      get :administrate_group, id: @application.id
      assigns(:ideas).should be_kind_of(ActiveRecord::Relation)
      assigns(:ideas).first.should be_kind_of(Idea)
      assigns(:idea_group).first.should be_an_instance_of(Idea)
    end
  end
end
