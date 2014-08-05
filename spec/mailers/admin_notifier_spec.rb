require "spec_helper"

describe AdminNotifier do
  describe '.send_to_group' do
    let(:users) { [User.make, User.make, User.make] }

    it 'should call new_idea for each user in the group' do
      notifier = AdminNotifier.send(:new)
      notifier.stub(:should_send_mail?) { true }
      notifier.stub_chain(:new_idea, :deliver) { true }
      expect(notifier).to receive(:new_idea).exactly(3).times
      notifier.send_to_group(users, User.make, Idea.make)
    end
  end
end
