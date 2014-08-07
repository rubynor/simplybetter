require 'spec_helper'

describe Vote do
  let(:valid_attributes) do
    {
        voter: User.make!,
        vote_receiver: Idea.make!,
        value: 1
    }
  end

  describe 'validations' do
    subject { Vote.new(valid_attributes) }
    it { should_not have_valid(:voter).when(nil) }
    it { should_not have_valid(:vote_receiver).when(nil) }
    it { should_not have_valid(:value).when(nil) }
  end

  describe '#cast_vote' do
    before do
      @vote = Vote.new(valid_attributes)
    end
    it 'returns if value is 0' do
      expect do
        @vote.cast_vote(0, 1)
      end.to raise_exception(ActiveRecord::RecordInvalid)
    end

    it 'sets value to 0' do
      expect do
        @vote.cast_vote(1, 1)
      end.to change { @vote.value }.from(1).to(0)
    end

    it 'raise exception if nil' do
      expect do
        @vote.cast_vote(nil, 1)
      end.to raise_exception(ActiveRecord::RecordInvalid)
    end

    it 'notifies subscribers' do
      @vote.should_receive(:notify)
      @vote.cast_vote(1, 1)
    end

    it 'subscribes voter to vote_receiver' do
      @vote.should_receive(:subscribe)
      @vote.cast_vote(-1, 1)
    end

    it 'updates parent vote count' do
      @vote.should_receive(:update_parent_votes_count)
      @vote.cast_vote(-1, 1)
    end

  end
end
