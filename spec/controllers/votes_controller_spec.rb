require 'spec_helper'

describe WidgetApi::VotesController do
  describe "voting on a idea" do
    example 'casting an up-vote' do
      idea = Idea.make!
      get(:up, token: idea.application.token, idea_id: idea.id, voter_email: "test@example.com", format: :json)
      Vote.count.should eq(1)
      Vote.first.value.should eq(1)
      Vote.first.vote_receiver.should eq(idea)
    end

    example 'changing a vote' do
      idea = Idea.make!
      vote = Vote.make!(value: 1, vote_receiver: idea)
      get(:up, token: idea.application.token, idea_id: idea.id, voter_email: vote.voter_email, format: :json)
      Vote.count.should eq(1)
      Vote.first.value.should eq(0)
    end
  end
  describe "voting on a comment" do
    example 'casting a vote' do
      comment = Comment.make!
      get(:up, token: comment.idea.application.token, comment_id: comment.id, voter_email: "test@example.com", format: :json)
      Vote.count.should eq(1)
      Vote.first.value.should eq(1)
      Vote.first.vote_receiver.should eq(comment)
    end

    example 'changing a vote' do
      comment = Comment.make!
      vote = Vote.make!(value: 1, vote_receiver: comment)
      get(:up, token: comment.idea.application.token, comment_id: comment.id, voter_email: vote.voter_email, format: :json)
      Vote.count.should eq(1)
      Vote.first.value.should eq(0)
    end
  end
end
