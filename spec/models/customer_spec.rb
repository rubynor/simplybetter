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
end
