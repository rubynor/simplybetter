require 'spec_helper'

describe CustomersController do

  let(:valid_attributes) do
    {
        name: 'My Name',
        email: 'my@email.com',
        password: 'password',
        password_confirmation: 'password'
    }
  end

  describe 'POST create' do
    it 'should create a new customer' do
      expect do
        post :create, customer: valid_attributes
      end.to change { Customer.count }.by(1)
    end

    it 'should render new when not valid' do
      Customer.any_instance.stub(:save).and_return(false)
      post :create, customer: valid_attributes
      response.should render_template :new
    end

    it 'should not create customer when not valid' do
      valid_attributes.delete(:email)
      expect do
        post :create, customer: valid_attributes
      end.to change { Customer.count }.by(0)
    end
  end

  describe 'update' do
    before do
      @customer = Customer.make! email: 'myemail@test.com', password: 'secret', name: 'my name'
      session[:customer_id] = @customer.id
    end
    describe 'PATCH update_unsafe' do
      describe 'change email' do
        it 'should update customers email' do
          patch :update_unsafe, id: @customer.to_param, customer: { email: 'test@test.no', current_password: 'secret' }
          response.should redirect_to edit_unsafe_customer_path(@customer.id)
          Customer.last.email.should eq('test@test.no')
        end
        it 'should render edit_unsafe' do
          patch :update_unsafe, id: @customer.to_param, customer: { email: '', current_password: 'secret' }
          response.should render_template :edit_unsafe
        end
        it 'should redirect to back' do
          request.env['HTTP_REFERER'] = edit_unsafe_customer_path(@customer.id)
          patch :update_unsafe, id: @customer.to_param, customer: { email: @customer.email, current_password: 's' }
          response.should redirect_to edit_unsafe_customer_path(@customer.id)
        end
      end
      describe 'change password' do
        it 'should update customers password' do
          patch :update_unsafe, id: @customer.to_param, customer: { password: '12345', password_confirmation: '12345', current_password: 'secret' }
          response.should redirect_to edit_unsafe_customer_path(@customer.id)
          Customer.last.password_digest.should_not eq(@customer.password_digest)
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
          response.should redirect_to request.env['HTTP_REFERER']
          Customer.last.name.should eq('Arne')
          flash[:error].should be(nil)
          flash[:notice].should_not be(nil)
        end
        it 'should flash error when name is blank' do
          put :update, id: @customer.to_param, customer: { name: '' }
          response.should redirect_to request.env['HTTP_REFERER']
          flash[:notice].should be(nil)
          flash[:error].should_not be(nil)
        end
      end
    end
  end
end
