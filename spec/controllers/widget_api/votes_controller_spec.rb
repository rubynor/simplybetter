require 'spec_helper'

describe WidgetApi::VotesController do

  before do
    @idea = Idea.make!
    @user = User.make!
    @user.widgets << @idea.application
  end

  describe 'voting on a idea' do
    example 'casting an up-vote' do
      post(:cast, value: 2, appkey: @idea.application.token, idea_id: @idea.id, email: @user.email, format: :json)
      expect(Vote.count).to eq(1)
      expect(Vote.first.value).to eq(1)
      expect(Vote.first.vote_receiver).to eq(@idea)
    end

    example 'cancel an upvote' do
      vote = Vote.make!(value: 1, vote_receiver: @idea, voter: @user)
      post(:cast,value: 2, appkey: @idea.application.token, idea_id: @idea.id, email: vote.voter.email, format: :json)
      expect(Vote.count).to eq(1)
      expect(Vote.first.value).to eq(0)
    end
  end

  describe 'voting on a comment' do
    example 'casting a vote' do
      comment = Comment.make!(idea: @idea)
      post(:cast, value: 2, appkey: comment.idea.application.token, comment_id: comment.id, email: @user.email, format: :json)
      expect(Vote.count).to eq(1)
      expect(Vote.first.value).to eq(1)
      expect(Vote.first.vote_receiver).to eq(comment)
    end

    example 'changing a vote' do
      comment = Comment.make!(idea: @idea)
      vote = Vote.make!(value: 1, vote_receiver: comment, voter: @user)
      post(:cast, value: 2, appkey: comment.idea.application.token, comment_id: comment.id, email: vote.voter.email, format: :json)
      expect(Vote.count).to eq(1)
      expect(Vote.first.value).to eq(0)
    end
  end
end
