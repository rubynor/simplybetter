require 'spec_helper'

describe CommentsController do
  example 'toggle visible' do
    idea = Idea.make!
    comment = Comment.make! idea: idea
    expect do
      patch :update, { id: comment.id, comment: { visible: false } }
    end.to change { Comment.last.visible }.from(true).to(false)
  end
end
