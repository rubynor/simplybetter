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
    vote.value ||= 0
    vote.value += params[:value].to_i
    vote.save!
    vote_receiver.reload

    respond_to do |format|
      format.js { render :json => {
          vote_receiver.class.to_s.downcase.to_sym => vote_receiver.to_json
      }, :callback => params[:callback] || vote_receiver.class.to_s.downcase }
    end
  end
end
