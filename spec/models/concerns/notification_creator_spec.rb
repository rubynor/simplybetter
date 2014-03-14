require 'spec_helper'

describe NotificationCreator do
  let(:user) { double("user") }
  let(:subject) { double("subject") }
  let(:action) { double("action") }

  context 'normal notification' do
    describe 'notify_group' do
      it 'should create notifications' do
        allow(action).to receive(:creator) { double("user") }
        expect(Notification).to receive(:create_with).with(action,subject,user).twice
        n = NotificationCreator.new(action, subject)
        n.notify_group([user,user])
      end

      it 'should not create notification if receiver equals action.creator' do
        allow(action).to receive(:creator) { user }
        expect(Notification).not_to receive(:create_with).with(action,subject,user)
        n = NotificationCreator.new(action,subject)
        n.notify_group([user])
      end
    end
  end

  context 'attribute notification' do
    describe 'notify_group' do
      let(:action_attribute) { double("action_attribute") }
      let(:action_attribute_changer) { double("user") }

      it 'should create notifications, even if receiver equals action.creator' do
        allow(action).to receive(:creator) { user }
        expect(Notification).not_to receive(:create_with).with(action,subject,user)
        expect(Notification).to receive(:create_with).with(action,subject,user,action_attribute,action_attribute_changer).once
        n = NotificationCreator.new(action,subject,action_attribute,action_attribute_changer)
        n.notify_group([user])
      end

      it 'should not create notification for the user who changed the attribute and triggered notification' do
        user = action_attribute_changer
        expect(Notification).to_not receive(:create_with)
        n = NotificationCreator.new(action,subject,action_attribute,user)
        n.notify_group([user])
      end
    end
  end
end
