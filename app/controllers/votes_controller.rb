class VotesController < ApplicationController
  def cast
    application = Application.find_by_token(params[:token])
    feature = application.features.find(params[:feature_id])
    feature.votes.create!(value: params[:value], voter_email: params[:voter_email])
    render nothing: true
  end
end
