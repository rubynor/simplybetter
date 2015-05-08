require 'spec_helper'

describe WidgetApi::CommentsController do
  include SessionHelper
  let(:idea) { Idea.make! }
  let(:user) { User.make! }

  example 'adding a comment' do
    user.widgets << idea.application
    post :create, idea_id: idea.id, comment: { body: 'Oh, hi thar!',idea_id: idea.id }, email: user.email, format: :json
    expect(response).to render_template(:show)
  end

  describe 'update comment' do
    example 'update my comment' do
      user.widgets << idea.application
      comment = Comment.make!(idea: idea, creator: user)
      expect do
        put :update, idea_id: idea.id, id: comment.id, comment: { body: 'new body tekst' }, email: user.email, format: :json
      end.to change { Comment.last.body }.from(comment.body).to('new body tekst')
    end

    example 'cant update others comment' do
      user.widgets << idea.application
      comment = Comment.make!(idea: idea)
      expect do
        put :update, idea_id: idea.id, id: comment.id, comment: { body: 'new body tekst' }, email: user.email, format: :json
      end.not_to change { Comment.last.body }
    end

    example 'admin - update visible' do
      sign_in_customer(Customer.make!)
      comment = Comment.make!(idea: idea)
      expect do
        put :update, idea_id: idea.id, id: comment.id, comment: { visible: false }, email: user.email, format: :json
      end.to change { Comment.last.visible }.from(true).to(false)
    end
  end
end
