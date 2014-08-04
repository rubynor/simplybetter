require 'spec_helper'

describe AdminNotifier do
  describe 'send email for new idea to app owners' do
    let(:customer) { Customer.make! }
    let(:group) { [customer, Customer.make!] }
    let(:idea) { Idea.make! }
    let(:creator) { idea.creator }
    let(:mail) { AdminNotifier.send_to_group(group, creator, idea) }

    it 'sends email' do
      expect do
        AdminNotifier.send_to_group(group, creator, idea)
      end.to change { ActionMailer::Base.deliveries.count }.by(2)
    end

    it 'renders the subject' do
      expect(mail.subject).to eql('SimplyBetter: A new idea has been submitted!')
    end

    it 'renders the body' do
      mail.body.encoded.should match('just submittet an idea on your SimplyBetter application')
    end
  end
end
