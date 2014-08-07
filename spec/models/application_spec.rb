require 'spec_helper'

describe Application do

  before :all do
    @application = Application.make!
  end

  let(:valid_attributes){ { name: 'My application' } }

  describe 'validations' do
    subject { Application.new(valid_attributes) }
    it { should_not have_valid(:name).when(nil) }
    it { should_not have_valid(:token).when(@application.token) }
  end

  describe 'should have many' do
    after :each do
      @reflection.macro.should == :has_many
    end
    it 'ideas' do
      @reflection = Application.reflect_on_association(:ideas)
    end
    it 'comments' do
      @reflection = Application.reflect_on_association(:comments)
    end
    it 'notifications' do
      @reflection = Application.reflect_on_association(:notifications)
    end
    it 'customers' do
      @reflection = Application.reflect_on_association(:customers)
    end
    it 'users' do
      @reflection = Application.reflect_on_association(:users)
    end
    it 'widget_customers' do
      @reflection = Application.reflect_on_association(:widget_customers)
    end
  end
end
