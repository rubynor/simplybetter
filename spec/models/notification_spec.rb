require 'spec_helper'

describe Notification do
  describe 'create_with' do
    let(:action) { Vote.make! }
    let(:subject) { Idea.make! }
    let(:recipient) { User.make! }

    it 'should create a notification' do
      expect {
        Notification.create_with(action: action, subject: subject, recipient: recipient, app_id: 1)
      }.to change{Notification.count}.from(0).to(1)
    end

    it 'should only create if it is unique' do
      expect {
        Notification.create_with(action: action, subject: subject, recipient: recipient, app_id: 1)
        Notification.create_with(action: action, subject: subject, recipient: recipient, app_id: 1)
      }.to change{Notification.count}.from(0).to(1)
    end

    it 'should raise if one of the required arguments are missing' do
      expect {
        Notification.create_with(action: action, subject: subject, recipient: nil, app_id: 1)
      }.to raise_exception
    end
  end
end
