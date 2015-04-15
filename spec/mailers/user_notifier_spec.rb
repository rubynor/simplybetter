require 'spec_helper'

describe UserNotifier do
  let(:customer) { Customer.make! }
  let(:group) { [customer, Customer.make!] }
  let(:comment) { Comment.make! }

  describe 'notify for new comment' do
    let(:mail) { UserNotifier.new_comment(customer, comment.creator, comment, comment.idea) }

    it 'sends email to application subscribers' do
      expect do
        UserNotifier.notify_group_comment(group, comment)
      end.to change { ActionMailer::Base.deliveries.count }.by(2)
    end

    it 'renders the subject' do
      expect(mail.subject).to eql("SimplyBetter: New comment on the idea: '#{comment.idea.title}'")
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(comment.body)
    end
  end

  describe 'Notify for completed idea' do
    let(:idea) { Idea.make! }
    let(:mail) { UserNotifier.idea_completed(User.make!, customer, idea) }

    it 'sends email to subscribers' do
      expect do
        UserNotifier.notify_group_completed(group, Customer.make!, idea)
      end.to change { ActionMailer::Base.deliveries.count }.by(2)
    end

    it 'renders the subject' do
      expect(mail.subject).to eql('SimplyBetter: An idea you commented has been implemented')
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('changed the status of the idea below to completed')
    end
  end
end
