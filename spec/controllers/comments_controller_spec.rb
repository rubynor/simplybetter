require 'spec_helper'

describe CommentsController do
  example 'adding a comment' do
    f = Feature.make!.id
    post :create, {body: 'Oh, hi thar!', feature_id: f, user_id: "test5@test.com"}
    response.should redirect_to feature_path(f)
  end

  context 'destroy a comment' do
    let(:comment) { Comment.make! }

    it 'deletes a comment' do
      comment
      expect {
        delete :destroy, id: comment.id, user_id: comment.user_id #Pål: Passing in user_id is not optimal
                                         # perhaps we should retrieve the user_id
                                         # from session/current_user method
      }.to change(Comment, :count).by(-1)
    end

    it 'redirects to feature' do
      delete :destroy, id: comment.id, user_id: comment.user_id
      response.should redirect_to feature_path(comment.feature.id)
    end

    it 'does not delete if user_id is not owner of comment' do
      pending "waiting for current_user"
      comment
      expect{
        delete :destroy, id: comment.id, user_id: comment.user_id
      }.to raise_error
    end
  end
end