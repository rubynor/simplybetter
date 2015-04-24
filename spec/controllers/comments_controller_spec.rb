require 'spec_helper'

describe CommentsController do

  include SessionHelper

  let(:idea) { Idea.make! }
  let(:comment) { Comment.make! idea: idea }

  describe 'update comment' do
    subject { patch :update, { id: comment.id, comment: { visible: false }, format: :json } }

    it 'updates for authorized customer' do
      customer = idea.creator
      customer.applications << idea.application
      sign_in_customer(customer)

      expect { subject }.to change { comment.reload.visible }.from(true).to(false)
    end

    it 'denies not signed in' do
      subject
      expect(response.status).to be(401)
    end

    it 'denies if app not in customers apps' do
      sign_in_customer(idea.creator)
      subject
      expect(response.status).to be(422)
    end
  end
end
