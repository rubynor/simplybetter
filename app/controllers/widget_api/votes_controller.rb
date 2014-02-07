class WidgetApi::VotesController < ApplicationController

  def cast
    vote = params[:value] || 0
    if vote > 1
      up
    elsif vote < -1
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
    get_vote
  end

  def cast_vote(value)
    if params[:voter_email].present?
      get_vote
      @vote.cast(value)
      @vote_receiver.reload
    else
      render json: {error: "You need to be signed in to vote"}, status: 403
    end
  end

  def find_application
    unless @application ||= Application.find_by_token(params[:token])
      raise "Can't find application"
    end
    @application
  end

  def vote_receiver
    application = find_application
    @vote_receiver ||= if params[:idea_id]
      application.ideas.find(params[:idea_id])
    elsif params[:comment_id]
      application.comments.find(params[:comment_id])
    else
      raise "No vote receiver"
    end
  end

  def get_vote
    @vote = vote_receiver.votes.find_or_initialize_by(voter_email: params[:voter_email])
  end

  #def cast
  #  application = Application.find_by_token(params[:token])
  #  if params[:idea_id]
  #    vote_receiver = application.ideas.find(params[:idea_id])
  #  elsif params[:comment_id]
  #    vote_receiver = application.comments.find(params[:comment_id])
  #  else
  #    raise "No vote receiver"
  #  end
  #
  #  vote = vote_receiver.votes.find_or_initialize_by(voter_email: params[:voter_email])
  #  vote.value ||= 0
  #  vote.value += params[:value].to_i
  #  vote.save!
  #  vote_receiver.reload
  #
  #  @idea = vote_receiver.instance_of?(Comment)? vote_receiver.idea : vote_receiver
  #
  #  respond_to do |format|
  #    format.json
  #  end
  #end
end
