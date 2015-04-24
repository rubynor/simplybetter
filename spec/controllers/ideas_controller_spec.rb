require 'spec_helper'

describe IdeasController do
  include SessionHelper

  describe 'logged in' do

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
      it 'should not notify if completed changed to false' do
        @idea.update_attributes! completed: true
        expect do
          put :update, application_id: @application.id, id: @idea.to_param, idea: { completed: false}, format: :json
        end.to change(Notification, :count).by(0)
      end
    end
  end

  describe 'not authorized' do
    before do
      @customer = Customer.make!
      @application = Application.make!
    end

    describe 'not signed in' do
      describe 'index' do
        it 'should assign return unauthorized' do
          get :index, application_id: @application.id, format: :json
          expect(response.status).to eq(401)
          expect(assigns(:application)).to eq(nil)
          expect(assigns(:ideas)).to eq(nil)
        end
      end

      describe 'PUT update' do
        before do
          @idea = Idea.make!(application: @application, completed: false)
          @idea.subscribe
        end
        describe 'set complete' do
          it 'it should not update' do
            expect do
              put :update, application_id: @application.id, id: @idea.to_param, idea: { completed: true}, format: :json
            end.to_not change{ Idea.last.completed }
            expect(response.status).to be(401)
          end
        end
      end
    end

    describe 'signed in, but no access to app' do
      before do
        sign_in_customer(@customer)
      end

      describe 'index' do
        it 'should assign return unauthorized' do
          get :index, application_id: @application.id, format: :json
          expect(response.status).to eq(401)
          expect(assigns(:application)).to eq(nil)
          expect(assigns(:ideas)).to eq(nil)
        end
      end

      describe 'PUT update' do
        before do
          @idea = Idea.make!(application: @application, completed: false)
          @idea.subscribe
        end
        describe 'set complete' do
          it 'it should not update' do
            expect do
              put :update, application_id: @application.id, id: @idea.to_param, idea: { completed: true}, format: :json
            end.to_not change{ Idea.last.completed }
            expect(response.status).to be(401)
          end
        end
      end
    end
  end
end
