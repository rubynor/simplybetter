require 'spec_helper'

describe WidgetApi::VotesController do

  before do
    @idea = Idea.make!
    @user = User.make!
    @user.applications << @idea.application
  end

  describe 'voting on a idea' do
    example 'casting an up-vote' do
      post(:cast, value: 2, token: @idea.application.token, idea_id: @idea.id, voter_email: @user.email, format: :json)
      Vote.count.should eq(1)
      Vote.first.value.should eq(1)
      Vote.first.vote_receiver.should eq(@idea)
    end

    example 'cancel an upvote' do
      vote = Vote.make!(value: 1, vote_receiver: @idea, voter: @user)
      post(:cast,value: 2, token: @idea.application.token, idea_id: @idea.id, voter_email: vote.voter.email, format: :json)
      Vote.count.should eq(1)
      Vote.first.value.should eq(0)
    end
  end

  describe 'voting on a comment' do
    example 'casting a vote' do
      comment = Comment.make!(idea: @idea)
      post(:cast, value: 2, token: comment.idea.application.token, comment_id: comment.id, voter_email: @user.email, format: :json)
      Vote.count.should eq(1)
      Vote.first.value.should eq(1)
      Vote.first.vote_receiver.should eq(comment)
    end

    example 'changing a vote' do
      comment = Comment.make!(idea: @idea)
      vote = Vote.make!(value: 1, vote_receiver: comment, voter: @user)
      post(:cast, value: 2, token: comment.idea.application.token, comment_id: comment.id, voter_email: vote.voter.email, format: :json)
      Vote.count.should eq(1)
      Vote.first.value.should eq(0)
    end
  end
end
