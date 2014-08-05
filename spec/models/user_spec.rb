require 'spec_helper'

describe User do
  before :all do
    @user = User.make!
  end
  let(:valid_attributes) do
    {
        email: 'lol@lol.com'
    }
  end

  describe 'validations' do
    subject { User.new(valid_attributes) }
    it { should_not have_valid(:email).when(nil) }
    it { should_not have_valid(:email).when(@user.email) }
    it { should_not have_valid(:email).when('lol.com') }
  end

  describe 'relations' do
    it 'should have many widgets' do
      t = User.reflect_on_association(:widgets)
      t.macro.should == :has_many
    end
  end
end
