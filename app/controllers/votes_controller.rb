class VotesController < ApplicationController
  def up
    cast_vote(1)
  end
  def down
    cast_vote(-1)
  end

  def status
    puts params[:email]
    vote = Vote.find_by(voter_email: params[:email], vote_receiver_id: params[:feature_id])
    value = if vote
      vote.value
    else
      0
    end
    render json: {value: value}.to_json
  end

  private

  def cast_vote(value)
    vote = vote_receiver.votes.find_or_initialize_by(voter_email: params[:voter_email])
    vote.cast(value)
    respond_to do |format|
      format.json { head :ok }
    end
  end

  def find_application
    Application.find_by_token(params[:token])
  end

  def vote_receiver
    application = find_application
    if params[:feature_id]
      application.features.find(params[:feature_id])
    elsif params[:comment_id]
      application.comments.find(params[:comment_id])
    else
      raise "No vote receiver"
    end
  end

  #def cast
  #  application = Application.find_by_token(params[:token])
  #  if params[:feature_id]
  #    vote_receiver = application.features.find(params[:feature_id])
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
  #  @feature = vote_receiver.instance_of?(Comment)? vote_receiver.feature : vote_receiver
  #
  #  respond_to do |format|
  #    format.json
  #  end
  #end
end
