require 'spec_helper'

shared_context 'unauthorized' do
  describe 'index' do
    it 'response unauthorized' do
      get :index, application_id: application.id, format: :json
      expect(response.status).to eq(401)
    end
  end

  describe 'PUT update' do
    subject { put :update, application_id: application.id, id: @idea.to_param, idea: { completed: true}, format: :json }

    before do
      @idea = Idea.make!(application: application, completed: false)
    end

    it 'it should not update' do
      expect{subject}.to_not change{ Idea.last.completed }
    end

    it 'shuold respond with unauthorized' do
      subject
      expect(response.status).to eq(401)
    end
  end
end


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
      let(:completed) { true }
      subject { put :update, application_id: @application.id, id: @idea.to_param, idea: { completed: completed}, format: :json }
      before do
        @idea = Idea.make!(application: @application, completed: false)
        @idea.subscribe
      end

      describe 'set complete' do
        it 'sets completed to true' do
          expect { subject }.to change{ Idea.last.completed }.from(false).to(true)
        end
        it 'notifies idea owner' do
          expect { subject }.to change(Notification, :count).by(1)
        end
      end

      it 'should not notify if completed changed to false' do
        @idea.update_attributes! completed: true
        completed = false
        expect { subject }.to change(Notification, :count).by(0)
      end
    end
  end

  describe 'not signed in' do
    let(:application) { Application.make! }
    it_behaves_like 'unauthorized'
  end

  describe 'signed in, but not access to app' do
    before do
      sign_in_customer(Customer.make!)
    end
    let(:application) { Application.make!(customers: [Customer.make!]) }
    it_behaves_like 'unauthorized'
  end

end
