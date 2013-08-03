require 'spec_helper'

describe CommentsController do
  example 'adding a comment' do
    f = Feature.make!.id
    post :create, {body: 'Oh, hi thar!', feature_id: f, user_id: 1}
    response.should redirect_to feature_path(f)
  end
end