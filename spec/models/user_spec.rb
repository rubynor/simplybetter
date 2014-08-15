require 'spec_helper'

describe User do
  let(:valid_attributes) do
    {
        email: 'lol@lol.com'
    }
  end

  describe 'validations' do
    subject { User.new(valid_attributes) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.not_to allow_value('lol.com').for(:email) }
  end

  describe 'relations' do
    it 'should have many widgets' do
      t = User.reflect_on_association(:widgets)
      expect(t.macro).to eq(:has_and_belongs_to_many)
    end
  end

  describe 'set email setting' do
    it 'creates email setting' do
      user = User.create!(valid_attributes)
      expect(user.reload.email_setting.mailable).to eq(user)
    end

    it 'should set email setting after create' do
      user = User.new(valid_attributes)
      expect(user).to receive(:create_email_setting)
      user.save!
    end
  end
end
