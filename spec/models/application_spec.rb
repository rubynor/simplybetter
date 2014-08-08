require 'spec_helper'

describe Application do
  let(:valid_attributes){ { name: 'My application' } }

  describe 'validations' do
    subject { Application.new(valid_attributes) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:token) }
  end

  describe 'has_many association' do
    after :each do
      expect(@reflection.macro).to eq(:has_many)
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
  end
  describe 'has_and_belongs_to_many association' do
    after :each do
      expect(@reflection.macro).to eq(:has_and_belongs_to_many)
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
