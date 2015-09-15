require 'spec_helper'

describe CollaboratorsController do
  include SessionHelper

  before do
    @customer = Customer.make!
    @application = Application.make!(customers: [@customer], owner: @customer)
    sign_in_customer(@application.customers.first)
  end

  describe 'create' do
    let(:email) { 'test@invite.com' }
    let(:name) { 'Bob' }
    let(:invite) { post :create, application_id: @application.id, email: email, name: name }

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
        post :create, application_id: @application.id, email: email, name: ''
        expect(response.body).to include('errors')
      end
    end
  end

  describe 'destroy' do
    let(:customer) { Customer.make! }

    before do
      @application.customers << customer
    end

    it 'should remove collaborator' do
      expect(@application.customers.count).to eql(2)
      delete :destroy, application_id: @application.id, id: customer.id
      expect(@application.customers.count).to eql(1)
    end

    context 'user removes it\'s own user' do
      it 'should return an error' do
        delete :destroy, application_id: @application.id, id: @customer.id
        expect(response.status).to eql(400)
      end
    end
  end
end
