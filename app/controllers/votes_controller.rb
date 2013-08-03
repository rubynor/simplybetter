class VotesController < ApplicationController
  def cast
    application = Application.find_by_token(params[:token])
    feature = application.features.find(params[:feature_id])
    vote = feature.votes.find_or_initialize_by(voter_email: params[:voter_email])
    vote.value = params[:value]
    vote.save!
    feature.reload
    render js: "$('#feature_#{feature.id} .votes').text('#{feature.votes_count}')"
  end
end
