class WidgetApi::VotesController < ApplicationController
  include CreatorFinder

  def cast
    vote_val = params[:value] || 0
    if vote_val > 1
      up
    elsif vote_val < -1
      down
    else
      status
    end
  end


  private

  def up
    cast_vote(1)
  end

  def down
    cast_vote(-1)
  end

  def status
    vote_receiver
    if voter
      vote
    else
      @vote = Vote.new
    end
  end

  def cast_vote(value)
    if voter
      vote.cast(value)
      vote_receiver.reload
    else
      render json: {error: "You need to be signed in to vote"}, status: 403
    end
  end

  def application
    unless @application ||= Application.find_by_token(params[:token])
      raise "Can't find application"
    end
    @application
  end

  def vote_receiver
    @vote_receiver ||= if params[:idea_id]
      application.ideas.find(params[:idea_id])
    elsif params[:comment_id]
      application.comments.find(params[:comment_id])
    else
      raise "No vote receiver"
    end
  end

  def vote
    @vote ||= voter.votes.find_or_initialize_by(vote_receiver: vote_receiver)
  end

  def voter
    get_voter
  end

  def get_voter
    return_val = nil
    begin
      return_val = creator(application,params[:voter_email])
    rescue Exception => msg
    end
    return_val
  end
end
