require 'spec_helper'

describe CommentsController do
  example 'adding a comment' do
    f = Feature.make!.id
    post :create, {comment: {body: 'Oh, hi thar!', feature_id: f, user_id: 1} }
    response.should redirect_to feature_path(f)
  end

  describe 'action index' do
    it 'should show all the comments per feature' do
      c = Comment.make!
      get :index, feature_id: c.feature.id
      assigns(:comments).should == c.feature.comments
    end
  end
end