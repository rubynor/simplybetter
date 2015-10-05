require 'spec_helper'

describe CustomersController do

  include SessionHelper

  let(:valid_attributes) do
    {
        name: 'My Name',
        email: 'my@email.com',
        password: 'password',
        password_confirmation: 'password',
        promotion_code: 'promo'
    }
  end

  describe 'POST create' do
    it 'should create a new customer' do
      expect do
        post :create, customer: valid_attributes
      end.to change { Customer.count }.by(1)
    end

    it 'should render new when not valid' do
      allow_any_instance_of(Customer).to receive(:save).and_return(false)
      post :create, customer: valid_attributes
      expect(response).to render_template :new
    end

    it 'should not create customer when not valid' do
      valid_attributes.delete(:email)
      expect do
        post :create, customer: valid_attributes
      end.to change { Customer.count }.by(0)
    end

    it 'should register promotion code' do
      expect do
        post :create, customer: valid_attributes
      end.to change { Customer.count }.by(1)
      expect(Customer.last.promotion_code).to eq('promo')
    end
  end

  describe 'update' do
    before do
      @customer = Customer.make! email: 'myemail@test.com', password: 'dev', name: 'my name'
      sign_in_customer(@customer)
    end
    describe 'PATCH update_unsafe' do
      describe 'change email' do
        it 'should update customers email' do
          patch :update_unsafe, id: @customer.to_param, customer: { email: 'test@test.no', current_password: 'dev' }
          expect(response).to redirect_to edit_unsafe_customer_path(@customer.id)
          expect(Customer.last.email).to eq('test@test.no')
        end
        it 'should render edit_unsafe' do
          patch :update_unsafe, id: @customer.to_param, customer: { email: '', current_password: 'dev' }
          expect(response).to render_template :edit_unsafe
        end
        it 'should redirect to back' do
          request.env['HTTP_REFERER'] = edit_unsafe_customer_path(@customer.id)
          patch :update_unsafe, id: @customer.to_param, customer: { email: @customer.email, current_password: 's' }
          expect(response).to redirect_to edit_unsafe_customer_path(@customer.id)
        end
      end
      describe 'change password' do
        it 'should update customers password' do
          patch :update_unsafe, id: @customer.to_param, customer: { password: '12345', password_confirmation: '12345', current_password: 'dev' }
          expect(response).to redirect_to edit_unsafe_customer_path(@customer.id)
          expect(Customer.last.password_digest).not_to eq(@customer.password_digest)
        end
      end
    end
    describe 'PUT update' do
      before do
        request.env['HTTP_REFERER'] = edit_customer_path(@customer.id)
      end
      describe 'change name' do
        it 'should update customers name' do
          put :update, id: @customer.to_param, customer: { name: 'Arne' }
          expect(response).to redirect_to request.env['HTTP_REFERER']
          expect(Customer.last.name).to eq('Arne')
          expect(flash[:error]).to be(nil)
          expect(flash[:notice]).not_to be(nil)
        end
        it 'should flash error when name is blank' do
          put :update, id: @customer.to_param, customer: { name: '' }
          expect(response).to redirect_to request.env['HTTP_REFERER']
          expect(flash[:notice]).to be(nil)
          expect(flash[:error]).not_to be(nil)
        end
      end
    end
  end
end
