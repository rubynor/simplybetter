class VotesController < ApplicationController
  def cast
    application = Application.find_by_token(params[:token])
    if params[:feature_id]
      vote_receiver = application.features.find(params[:feature_id])
    elsif params[:comment_id]
      vote_receiver = application.comments.find(params[:comment_id])
    else
      raise "No vote receiver"
    end
    vote = vote_receiver.votes.find_or_initialize_by(voter_email: params[:voter_email])
    vote.value = params[:value]
    vote.save!
    vote_receiver.reload
    render js: "$('##{vote_receiver.class.to_s.downcase}_#{vote_receiver.id} .votes').text('#{vote_receiver.votes_count}')"
  end
end
