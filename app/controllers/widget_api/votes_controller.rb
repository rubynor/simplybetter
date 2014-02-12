class WidgetApi::VotesController < ApplicationController

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
    vote
  end

  def cast_vote(value)
    if voter.present?
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
    @voter ||= get_voter
  end

  def get_voter
    voter = false
    if application.customer.email == params[:voter_email]
      voter = application.customer
    else
      voter = application.users.find_by(email: params[:voter_email])
    end
  end
end
