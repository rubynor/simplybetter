require 'spec_helper'

describe IdeasController do
  include SessionHelper

  before do
    @customer = Customer.make!
    @application = Application.make!(customers: [@customer])
    sign_in_customer(@customer)
  end

  describe 'index' do
    it 'should assign @ideas variable' do
      get :index, application_id: @application.id, format: :json
      expect(assigns(:ideas)).to eq(@application.ideas)
    end
  end

  describe 'PUT update' do
    before do
      @idea = Idea.make!(application: @application, completed: false)
      @idea.subscribe
    end
    describe 'set complete' do
      it 'sets completed to true' do
        expect do
          put :update, application_id: @application.id, id: @idea.to_param, idea: { completed: true}, format: :json
        end.to change{ Idea.last.completed }.from(false).to(true)
      end
      it 'notifies idea owner' do
        expect do
          put :update, application_id: @application.id, id: @idea.to_param, idea: { completed: true}, format: :json
        end.to change(Notification, :count).by(1)
      end
    end
  end
end
