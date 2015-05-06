require 'spec_helper'

describe WidgetApi::IdeasController do
  include SessionHelper

  before do
    @user = User.make!
    @application = Application.make!(users: [@user])
  end

  describe 'GET index' do
    it 'should assign @ideas variable' do
      get :index, appkey: @application.token, email: @user.email, format: :json
      expect(assigns(:ideas)).to eq(@application.ideas.visible)
    end
  end

  describe 'GET show' do
    it 'should assign @idea variable' do
      @idea = Idea.make!(application: @application)
      get :show, appkey: @application.token, id: @idea.to_param, email: @user.email, format: :json
      expect(assigns(:idea)).to eq(@idea)
    end
  end

  describe 'PATCH/PUT update' do
    before do
      @idea = Idea.make!(application: @application, creator: @user)
    end
    it 'updates the idea title' do
      expect do
        patch :update, appkey: @application.token, id: @idea.to_param, email: @user.email, idea: { title: 'Edited title' }, format: :json
      end.to change { Idea.last.title }.from(@idea.title).to('Edited title')
    end
    it 'updates the idea description' do
      expect do
        patch :update, appkey: @application.token, id: @idea.to_param, email: @user.email, idea: { description: 'Edited description' }, format: :json
      end.to change { Idea.last.description }.from(@idea.description).to('Edited description')
    end
    it 'should raise error if validation fails' do
      expect do
        patch :update, appkey: @application.token, id: @idea.to_param, email: @user.email, idea: { description: '' }, format: :json
      end.to raise_error
    end
    it 'should return forbidden unless owner of idea' do
      user = User.make!
      user.widgets << @application
      patch :update, appkey: @application.token, id: @idea.to_param, email: user.email, idea: { description: 'Edited description' }, format: :json
      expect(response.status).to eq(403)
    end

    context 'edited by admin' do
      before do
        @customer = Customer.make!
        @application.customers << @customer
        sign_in_customer(@customer)
        @idea.description = 'New edited description'
        put :update, token: @application.token, id: @idea, user_email: @user.email, idea: @idea.attributes, format: :json
        @idea.reload
      end

      it 'should set last_edit_admin to current_customer' do
        expect(@idea.last_edit_admin).to eql(@customer)
      end

      it 'should set last_edit_admin_time to the current time' do
        expect(@idea.last_edit_admin_time).to be_an_instance_of(ActiveSupport::TimeWithZone)
      end
    end

    it 'should not set last_edit_admin' do
      patch :update, token: @application.token, id: @idea.to_param, user_email: @user.email, idea: { description: 'Edited description' }, format: :json
      @idea.reload
      expect(@idea.last_edit_admin).to be_nil
    end
  end

  describe 'POST create' do
    it 'creates a new idea' do
      expect do
        post :create,
             appkey: @application.token,
             email: @user.email,
             idea: { title: 'My awesome idea', description: 'My awesome description' },
             format: :json
      end.to change(Idea, :count).by(1)
    end
    it 'should return 422' do
      expect do
        post :create, appkey: @application.token, email: @user.email, idea: { description: '' }, format: :json
      end.to_not change(Idea, :count)
      expect(response.status).to eq(422) # :unprocessable_entity
    end
  end

  describe 'DELETE destroy' do
    it 'should destroy the idea' do
      idea = Idea.make!
      expect do
        delete :destroy, id: idea.to_param, format: :json
      end.to change(Idea, :count).by(-1)
    end
  end

  describe 'GET find_similar' do
    it 'assigns @ideas with search results' do
      idea = Idea.make! application: @application
      Idea.reindex
      get :find_similar, appkey: @application.token, query: idea.title, format: :json
      expect(assigns(:ideas).results).to eq([idea])
    end
  end
end
