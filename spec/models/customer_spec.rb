require 'spec_helper'

describe Customer, type: :model do

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
    it { is_expected.not_to have_valid(:name).when(nil) }
    it { is_expected.not_to have_valid(:email).when(nil) }
    it { is_expected.not_to have_valid(:email).when('jh') }
    it { is_expected.not_to have_valid(:password_digest).when(nil) }
  end

  describe 'send_password_reset' do
    it 'should genereate tokens and send mail' do
      customer = Customer.new(valid_attributes)
      expect_any_instance_of(CustomerMailer).to receive(:password_reset).with(customer)
      customer.send_password_reset
      expect(customer.password_reset_token).not_to eq(nil)
      expect(customer.password_reset_sent_at).not_to eq(nil)
    end
  end
end
