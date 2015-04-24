require 'spec_helper'

describe CommentsController do

  include SessionHelper

  describe 'update comment' do
    example 'updates for authorized customer' do
      idea = Idea.make!
      comment = Comment.make! idea: idea
      customer = idea.creator
      customer.applications << idea.application
      sign_in_customer(idea.creator)

      expect do
        patch :update, { id: comment.id, comment: { visible: false } }
      end.to change { Comment.last.visible }.from(true).to(false)
    end

    example 'denies not signed in' do
      idea = Idea.make!
      comment = Comment.make! idea: idea

      patch :update, { id: comment.id, comment: { visible: false } }
      expect(response.status).to be(302)
    end

    example 'denies if app not in customers apps' do
      idea = Idea.make!
      comment = Comment.make! idea: idea
      sign_in_customer(idea.creator)

      patch :update, { id: comment.id, comment: { visible: false } }
      expect(response.status).to be(422)
    end
  end
end
