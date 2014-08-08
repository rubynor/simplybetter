require 'spec_helper'

describe MailerHelpers do
  class Dummy
    include MailerHelpers
  end

  subject { Dummy.new }

  describe '.should_send_mail?' do
    context 'user matches the person who triggered the notification' do
      it 'should return false' do
        user = User.make
        expect(subject.should_send_mail?(user, user)).to be_falsey
      end
    end

    context 'user has unsubscribed from emails' do
      it 'should return false' do
        user = User.make!
        user.email_setting.update_attributes(unsubscribed: true)
        expect(subject.should_send_mail?(user, User.make)).to be_falsey
      end
    end

    it 'should return true' do
      expect(subject.should_send_mail?(User.make, User.make)).to be_truthy
    end
  end
end
