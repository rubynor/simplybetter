require 'spec_helper'

describe Comment do
  before :all do
    @idea = Idea.make!
  end
  let(:valid_attributes) { { body: 'O hai thar', idea: @idea, creator: User.make! } }

  describe 'validations' do
    subject { Comment.new(valid_attributes) }
    it { should_not have_valid(:body).when(nil) }
    it { should_not have_valid(:idea).when(nil) }
    it { should_not have_valid(:creator).when(nil) }
  end

  it 'should respond to idea' do
    c = Comment.make!
    c.should respond_to(:idea)
  end

  describe '#save_and_notify' do
    it 'should save an idea' do
      expect do
        Comment.new(valid_attributes).save_and_notify!
      end.to change(Comment, :count).by 1
    end

    it 'should subscribe commenter to idea' do
      expect do
        Comment.new(valid_attributes).save_and_notify!
      end.to change(IdeaSubscription, :count).by 1
    end

    it 'should notify idea creator' do
      @idea.subscribe
      expect do
        Comment.new(valid_attributes).save_and_notify!
      end.to change(Notification, :count).by 1
    end
  end
end
