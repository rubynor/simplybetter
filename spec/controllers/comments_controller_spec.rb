require 'spec_helper'

describe CommentsController do
  example 'adding a comment' do
    pending
    f = Feature.make!.id
    u = User.make!.email
    post :create, {feature_id: f, comment: {body: 'Oh, hi thar!', user_email: u,feature_id: f}}
    response.should redirect_to feature_path(f)
  end

  context 'destroy a comment' do
    let(:comment) { Comment.make! }

    it 'deletes a comment' do
      pending
      comment
      expect {
        delete :destroy, id: comment.id
      }.to change(Comment, :count).by(-1)
    end

    it 'redirects to feature' do
      comment
      delete :destroy,  id: comment.id
      response.should redirect_to feature_path(comment.feature.id)
    end
  end
end
