require 'spec_helper'

describe Customer do

  let(:valid_attributes) do
    {
        name: 'My Name',
        email: 'my@email.com',
        password: 'password',
        password_confirmation: 'password'
    }
  end

  describe 'validations' do
    subject { Customer.new(valid_attributes) }
    it { should_not have_valid(:name).when(nil) }
    it { should_not have_valid(:email).when(nil) }
    it { should_not have_valid(:email).when('jh') }
    it { should_not have_valid(:password_digest).when(nil) }
    it { should_not have_valid(:password_confirmation).when(nil) }
  end

  describe 'send_password_reset' do
    it 'should genereate tokens and send mail' do
      customer = Customer.new(valid_attributes)
      CustomerMailer.any_instance.should_receive(:password_reset).with(customer)
      customer.send_password_reset
      customer.password_reset_token.should_not eq(nil)
      customer.password_reset_sent_at.should_not eq(nil)
    end
  end
end
