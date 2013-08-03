class VotesController < ApplicationController
  def cast
    application = Application.find_by_token(params[:token])
    feature = application.features.find(params[:feature_id])
    feature.votes.create!(value: params[:value], voter_email: params[:voter_email])
    feature.reload
    render js: "$('#feature_#{feature.id} .votes').text('#{feature.votes_count}')"
  end
end
