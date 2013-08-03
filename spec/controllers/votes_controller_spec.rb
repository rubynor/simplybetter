require 'spec_helper'

describe VotesController do
  example 'casting a vote' do
    feature = Feature.make!
    post(:cast, token: feature.application.token, feature_id: feature.id, voter_email: "test@example.com", value: 1)
    Vote.count.should eq(1)
    Vote.first.value.should eq(1)
  end

  example 'changing a vote' do
    feature = Feature.make!
    vote = Vote.make!(value: 1, feature: feature)
    post(:cast, token: feature.application.token, feature_id: feature.id, voter_email: vote.voter_email, value: -1)
    Vote.count.should eq(1)
    Vote.first.value.should eq(-1)
  end
end
