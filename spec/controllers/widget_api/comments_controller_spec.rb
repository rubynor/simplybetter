require 'spec_helper'

describe WidgetApi::CommentsController do
  let(:idea) { Idea.make! }

  example 'adding a comment' do
    u = User.make!
    u.widgets << idea.application
    post :create, { idea_id: idea.id, comment: { body: 'Oh, hi thar!',idea_id: idea.id }, user_email: u.email, format: :json }
    expect(response).to render_template(:show)
  end

  example 'updating a comment' do
    comment = Comment.make!(idea: idea)
    expect do
      put :update, { idea_id: idea.id, id: comment.id, comment: { visible: false }, format: :json }
    end.to change { Comment.last.visible }.from(true).to(false)
  end
end
