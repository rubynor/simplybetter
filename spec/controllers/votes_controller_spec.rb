require 'spec_helper'

describe WidgetApi::VotesController do
  describe "voting on a idea" do
    example 'casting an up-vote' do
      user = User.make!
      idea = Idea.make!
      idea = Idea.make!
      post(:cast, value: 2, token: idea.application.token, idea_id: idea.id, voter_email: user.email, format: :json)
      Vote.count.should eq(1)
      Vote.first.value.should eq(1)
      Vote.first.vote_receiver.should eq(idea)
    end

    example 'cancel an upvote' do
      idea = Idea.make!
      vote = Vote.make!(value: 1, vote_receiver: idea)
      post(:cast,value: 2, token: idea.application.token, idea_id: idea.id, voter_email: vote.voter.email, format: :json)
      Vote.count.should eq(1)
      Vote.first.value.should eq(0)
    end
  end

  describe "voting on a comment" do
    example 'casting a vote' do
      comment = Comment.make!
      voter = User.make!
      post(:cast, value: 2, token: comment.idea.application.token, comment_id: comment.id, voter_email: voter.email, format: :json)
      Vote.count.should eq(1)
      Vote.first.value.should eq(1)
      Vote.first.vote_receiver.should eq(comment)
    end

    example 'changing a vote' do
      comment = Comment.make!
      vote = Vote.make!(value: 1, vote_receiver: comment)
      post(:cast, value: 2, token: comment.idea.application.token, comment_id: comment.id, voter_email: vote.voter.email, format: :json)
      Vote.count.should eq(1)
      Vote.first.value.should eq(0)
    end
  end
end
