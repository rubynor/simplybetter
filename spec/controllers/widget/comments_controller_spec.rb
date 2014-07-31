require 'spec_helper'

describe WidgetApi::CommentsController do
  let(:idea) { Idea.make! }

  example 'adding a comment' do
    u = User.make!
    u.applications << idea.application
    post :create, { idea_id: idea.id, comment: { body: 'Oh, hi thar!',idea_id: idea.id }, user: { email: u.email }, format: :json }
    response.should render_template(:show)
  end
end
