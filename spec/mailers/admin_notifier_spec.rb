require 'spec_helper'

describe AdminNotifier do
  describe '.send_to_group' do
    let(:users) { [User.make, User.make, User.make] }

    it 'should call new_idea for each user in the group' do
      notifier = AdminNotifier.send(:new)
      allow(notifier).to receive(:should_send_mail?) { true }
      allow(notifier).to receive_message_chain(:new_idea, :deliver) { true }
      expect(notifier).to receive(:new_idea).exactly(3).times
      notifier.send_to_group(users, Idea.make)
    end
  end

  describe 'send email for new idea to app owners' do
    let(:customer) { Customer.make! }
    let(:group) { [customer, Customer.make!] }
    let(:idea) { Idea.make! }
    let(:mail) { AdminNotifier.send_to_group(group, idea) }

    it 'sends email' do
      expect do
        AdminNotifier.send_to_group(group, idea)
      end.to change { ActionMailer::Base.deliveries.count }.by(2)
    end

    it 'renders the subject' do
      expect(mail.subject).to eql('SimplyBetter: A new idea has been submitted!')
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('just submittet an idea on your SimplyBetter application')
    end
  end
end
