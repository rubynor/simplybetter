require 'spec_helper'

describe CommentsController do
  example 'deleting a comment' do
    idea = Idea.make!
    comment = Comment.make! idea: idea
    expect do
      delete :destroy, {id: comment.id }
    end.to change { Comment.count }.by -1
    response.status.should be(200)
  end
end
