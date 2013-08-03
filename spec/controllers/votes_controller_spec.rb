require 'spec_helper'

describe VotesController do
  describe "voting on a feature" do
    example 'casting a vote' do
      feature = Feature.make!
      post(:cast, token: feature.application.token, feature_id: feature.id, voter_email: "test@example.com", value: 1)
      Vote.count.should eq(1)
      Vote.first.value.should eq(1)
      Vote.first.vote_receiver.should eq(feature)
    end

    example 'changing a vote' do
      feature = Feature.make!
      vote = Vote.make!(value: 1, vote_receiver: feature)
      post(:cast, token: feature.application.token, feature_id: feature.id, voter_email: vote.voter_email, value: -1)
      Vote.count.should eq(1)
      Vote.first.value.should eq(-1)
    end
  end
  describe "voting on a comment" do
    example 'casting a vote' do
      comment = Comment.make!
      post(:cast, token: comment.feature.application.token, comment_id: comment.id, voter_email: "test@example.com", value: 1)
      Vote.count.should eq(1)
      Vote.first.value.should eq(1)
      Vote.first.vote_receiver.should eq(comment)
    end

    example 'changing a vote' do
      comment = Comment.make!
      vote = Vote.make!(value: 1, vote_receiver: comment)
      post(:cast, token: comment.feature.application.token, comment_id: comment.id, voter_email: vote.voter_email, value: -1)
      Vote.count.should eq(1)
      Vote.first.value.should eq(-1)
    end
  end
end
