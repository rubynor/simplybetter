require 'spec_helper'

describe VotesController do
  example 'casting a vote' do
    feature = Feature.make!
    post(:cast, token: feature.customer.token, feature_id: feature.id, user_id: 42, value: 1)
    Vote.count.should eq(1)
    Vote.first.value.should eq(1)
  end
end
