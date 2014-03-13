require 'spec_helper'

describe WidgetApi::CommentsController do
  example 'adding a comment' do
    pending
    f = Idea.make!.id
    u = User.make!.email
    post :create, {idea_id: f, comment: {body: 'Oh, hi thar!', user_email: u,idea_id: f}}
    response.should redirect_to applicataion_idea_path(f)
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

    it 'redirects to idea' do
      pending
      comment
      delete :destroy,  id: comment.id
      response.should redirect_to application_idea_path(comment.idea.id)
    end
  end
end
