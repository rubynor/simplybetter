class VotesController < ApplicationController
  def cast
    customer = Customer.find_by_token(params[:token])
    feature = customer.features.find(params[:feature_id])
    feature.votes.create!(value: params[:value])
    render nothing: true
  end
end
