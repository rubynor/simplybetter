require 'spec_helper'

describe ApplicationsController do
  include SessionHelper

  before do
    @customer = Customer.make!
    @application = Application.make!(customers: [@customer])
    sign_in_customer(@application.customers.first)
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
end
