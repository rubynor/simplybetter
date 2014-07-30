require 'spec_helper'

describe WidgetApi::IdeasController do
  include SessionHelper

  before do
    @user = User.make!
    @application = Application.make!(users: [@user])
  end

  describe 'GET index' do
    it 'should assign @ideas variable' do
      get :index, token: @application.token, user_email: @user.email, format: :json
      expect(assigns(:ideas)).to eq(@application.ideas.visible)
    end
  end

  describe 'GET show' do
    it 'should assign @idea variable' do
      @idea = Idea.make!(application: @application)
      get :show, token: @application.token, id: @idea.to_param, user_email: @user.email, format: :json
      expect(assigns(:idea)).to eq(@idea)
    end
  end

  describe 'PUT update' do
    # TODO: It should not be possible to update idea without a user... And user should be owner..
    before do
      @idea = Idea.make!(application: @application)
    end
    it 'updates the idea title' do
      expect do
        put :update, token: @application.token, id: @idea.to_param, idea: { title: 'Edited title' }, format: :json
      end.to change { Idea.last.title }.from(@idea.title).to('Edited title')
    end
    it 'updates the idea description' do
      expect do
        put :update, token: @application.token, id: @idea.to_param, idea: { description: 'Edited description' }, format: :json
      end.to change { Idea.last.description }.from(@idea.description).to('Edited description')
    end
  end

  describe 'POST create' do
    it 'creates a new idea' do
      expect do
        post :create, token: @application.token, user: { email: @user.email }, idea: { title: 'My awesome idea', description: 'My awesome description' }, format: :json
      end.to change( Idea, :count).by(1)
    end
  end
end
