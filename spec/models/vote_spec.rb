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
    it { is_expected.to validate_presence_of(:voter) }
    it { is_expected.to validate_presence_of(:vote_receiver) }
    it { is_expected.to validate_presence_of(:value) }
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
      expect(@vote).to receive(:notify)
      @vote.cast_vote(1, 1)
    end

    it 'subscribes voter to vote_receiver' do
      expect(@vote).to receive(:subscribe)
      @vote.cast_vote(-1, 1)
    end

    it 'updates parent vote count' do
      expect(@vote).to receive(:update_parent_votes_count)
      @vote.cast_vote(-1, 1)
    end

  end
end
