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
      expect(assigns(:applications).first).to be_kind_of(Application)
    end
  end

  describe 'show' do
    it 'should assign @application' do
      get :show, id: @application.id, format: :json
      expect(assigns(:application)).to be_an_instance_of(Application)
    end
  end

  describe 'create' do
    it 'should create a new application' do
      expect {
        post :create, application: {name: 'The bestest application'}
      }.to change{ Application.all.count }.by(1)
    end
    it 'should redirect to customization_applications_path' do
      post :create, application: {name: 'The bestest application'}
      expect(response).to redirect_to(customization_application_path(Application.last.id))
    end
  end

  describe 'add_collaborator' do
    let(:email) { 'test@invite.com' }
    let(:name) { 'Bob' }
    let(:invite) { post :add_collaborator, id: @application.id, email: email, name: name }

    context 'non existing user' do
      it 'should create a new user' do
        expect(Customer).to receive(:create!)
                        .with(a_hash_including(email:  email))
                        .and_call_original
        invite
        expect(@application.customers.map(&:email)).to include(email)
      end

      it 'should send an email' do
        expect(CustomerMailer).to receive(:add_new_collaborator).and_call_original
        invite
      end
    end

    context 'existing user' do
      before do
        Customer.make!(email: email, name: name)
      end

      it 'should invite user' do
        expect(@application.customers.count).to eql(1)
        invite
        expect(@application.customers.count).to eql(2)
      end

      it 'should send an email' do
        expect(CustomerMailer).to receive(:add_collaborator).and_call_original
        invite
      end
    end

    context 'customer is already in team' do
      before do
        @application.customers << Customer.make!(email: email)
      end

      it 'does not add customer to application.customers' do
        expect(@application.customers.count).to eql(2)
        invite
        expect(@application.customers.count).to eql(2)
      end

      it 'renders status conflict(409)' do
        invite
        expect(response.status).to eql(409)
      end
    end

    context 'validation errors' do
      it 'should render error messages' do
        post :add_collaborator, id: @application.id, email: email, name: ''
        expect(response.body).to include('errors')
      end
    end
  end

  describe 'remove_collaborator' do
    let(:customer) { Customer.make! }

    before do
      @application.customers << customer
    end

    it 'should remove collaborator' do
      expect(@application.customers.count).to eql(2)
      delete :remove_collaborator, id: @application.id, email: customer.email
      expect(@application.customers.count).to eql(1)
    end

    context 'user removes it\'s own user' do
      it 'should return an error' do
        delete :remove_collaborator, id: @application.id, email: @customer.email
        expect(response.status).to eql(400)
      end
    end
  end
end
