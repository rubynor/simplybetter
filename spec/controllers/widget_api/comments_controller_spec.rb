require 'spec_helper'

describe WidgetApi::CommentsController do
  include SessionHelper

  def shared_params
    { idea_id: idea.id, id: comment.id,
      comment: { body: 'new body tekst', visible: false } }
  end

  let(:idea) { Idea.make! }
  let(:user) { User.make! }
  let(:customer) { Customer.make! }
  let(:info_param) { encode_to_base64(idea.application.token, user.email, user.name) }
  let(:comment) { Comment.make! idea: idea }
  let(:params) { { email: user.email, token: idea.application.token }.merge!(shared_params) }
  let(:params_with_info) { { info: info_param }.merge!(shared_params) }

  context 'as widget user' do
    before do
      user.widgets << idea.application
    end

    describe 'creating a comment' do
      after { expect(response).to render_template(:show) }

      # TODO Hilde: Refactor
      # For some reason I can't do the same here as I do
      # with update (the use of params and params_with_info returns error)
      example 'with email and token params' do
        expect do
          post :create,
               idea_id: idea.id,
               comment: { body: 'Oh, hi thar!', idea_id: idea.id },
               email: user.email,
               token: idea.application.token,
               format: :json
        end.to change { Comment.count }.by(1)
      end

      example 'with info param' do
        expect do
          post :create,
               idea_id: idea.id,
               comment: { body: 'Oh, hi thar!', idea_id: idea.id },
               info: info_param,
               format: :json
        end.to change { Comment.count }.by(1)
      end
    end

    describe 'update comment' do
      context 'can update own comment' do
        before { comment.update_attributes creator: user }
        after { expect(response.status).to eq(200) }

        it 'with email and token params' do
          expect { put :update, params, format: :json }.to change { comment.reload.body }.from(comment.body).to('new body tekst')
        end

        it 'with info params' do
          expect { put :update, params_with_info }.to change { comment.reload.body }.from(comment.body).to('new body tekst')
        end
      end

      context 'cannot update ohters comments' do
        after { expect(response.status).to eq(403) }

        it 'with email and token params' do
          put :update, params, format: :json
        end

        it 'with info params' do
          put :update, params_with_info
        end
      end

      it 'cannot update visibility' do
        expect { put :update, params_with_info }.not_to change { comment.visible }
      end
    end
  end

  context 'as admin user' do
    before { sign_in_customer(customer) }

    example 'admin - update visible no access' do
      expect { put :update, params }.not_to change { comment.reload.visible }
    end

    example 'admin - update visible' do
      customer.applications << idea.application
      expect { put :update, params }.to change { comment.reload.visible }.from(true).to(false)
    end
  end

  # TODO Hilde: is this neccessary?
  context "customer has not visited it's widget, thus is not part of customer.widgets" do
    example 'adding a comment' do
      customer.applications << idea.application
      sign_in_customer(customer)
      post :create, idea_id: idea.id, comment: { body: 'Oh, hi thar!', idea_id: idea.id }, format: :json
      expect(response).to render_template(:show)
    end
  end
end
