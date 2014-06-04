require 'spec_helper'

describe PasswordResetsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe 'Send reset instructions' do
    it 'should set password_reset_token' do
      @customer = Customer.make!
      @customer.password_reset_token.should eq(nil)
      post :create, email: @customer.email
      response.should redirect_to root_url
      flash[:notice].should_not eq(nil)
      @customer.reload
      @customer.password_reset_token.should_not eq(nil)
    end
    it 'should just ignore if email not found' do
      post :create, email: 'nonexisting@mail.com'
      response.should redirect_to root_url
      flash[:notice].should_not eq(nil)
    end
  end

  describe 'create new password' do
    before do
      @customer = Customer.make!
      @customer.send_password_reset
    end
    it 'should create new password' do
      @customer.reload
      patch :update, id: @customer.password_reset_token, customer: { password: 'test', password_confirmation: 'test' }
      Customer.last.password_digest.should_not eq(@customer.password_digest)
    end
  end
end
