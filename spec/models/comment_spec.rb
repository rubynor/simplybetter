require 'spec_helper'

describe Comment do
  before :all do
    @idea = Idea.make!
  end
  let(:valid_attributes) { { body: 'O hai thar', idea: @idea, creator: User.make! } }

  describe 'validations' do
    subject { Comment.new(valid_attributes) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:idea) }
    it { is_expected.to validate_presence_of(:creator) }
  end

  it 'should respond to idea' do
    c = Comment.make!
    expect(c).to respond_to(:idea)
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
