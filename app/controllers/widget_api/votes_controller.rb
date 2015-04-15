class WidgetApi::VotesController < ApplicationController
  include CreatorFinder

  # POST / GET
  def cast
    # Early exit if voter is the creator of the idea..
    if voter.email == vote_receiver.creator.email
      return render json: { error: "You can't wote for your own ide" }, status: 403
    end
    vote_val = params[:value] || 0
    if vote_val == 0
      status
    elsif voter
      cast_vote(vote_val)
    else
      render json: { error: 'You need to be signed in to vote' }, status: 403
    end
  end

  private

  def status
    vote_receiver
    if voter
      vote
    else
      @vote = Vote.new
    end
  end

  def cast_vote(value)
    vote.cast_vote(value, @application.id)
    vote_receiver.reload
  end

  def application
    unless @application ||= Application.find_by(token: params[:token])
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
      raise 'No vote receiver'
    end
  end

  def vote
    @vote ||= voter.votes.find_or_initialize_by(vote_receiver: vote_receiver)
  end

  def voter
    creator(application, params[:voter_email])
  end
end
