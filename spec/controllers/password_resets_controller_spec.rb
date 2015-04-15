require 'spec_helper'

describe PasswordResetsController do

  describe 'GET "new"' do
    it 'returns http success' do
      get 'new'
      expect(response).to be_success
    end
  end

  describe 'Send reset instructions' do
    it 'should set password_reset_token' do
      @customer = Customer.make!
      expect(@customer.password_reset_token).to eq(nil)
      post :create, email: @customer.email
      expect(response).to redirect_to check_email_password_resets_path
      @customer.reload
      expect(@customer.password_reset_token).not_to eq(nil)
    end
    it 'should just ignore if email not found' do
      post :create, email: 'nonexisting@mail.com'
      expect(response).to redirect_to check_email_password_resets_path
    end
  end

  describe 'create new password' do
    before do
      @customer = Customer.make!
      @customer.send_password_reset
    end
    it 'should change password' do
      @customer.reload
      patch :update, id: @customer.password_reset_token, customer: { password: 'test', password_confirmation: 'test' }
      expect(Customer.last.password_digest).not_to eq(@customer.password_digest)
    end
    it 'should not change password if time limit is out' do
      Timecop.freeze(Time.zone.now + 2.hours)
      patch :update, id: @customer.password_reset_token, customer: { password: 'test', password_confirmation: 'test' }
      expect(Customer.last.password_digest).to eq(@customer.password_digest)
    end
  end
end
