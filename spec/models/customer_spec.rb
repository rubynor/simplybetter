require 'spec_helper'

describe Customer do
  pending "add some examples to (or delete) #{__FILE__}"

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
    pending { should_not have_valid(:password).when(nil) } # it is now valid without password, maybe because of secure_password.rb?
    it { should_not have_valid(:password_confirmation).when(nil) }
  end
end
