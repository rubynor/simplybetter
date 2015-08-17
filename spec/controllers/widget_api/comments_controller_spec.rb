require 'spec_helper'

describe WidgetApi::CommentsController do
  include SessionHelper

  def shared_params
    { idea_id: idea.id,
      comment: { body: 'new body tekst', visible: false, idea_id: idea.id },
      format: :json }
  end

  def info_param
    encode_to_base64(idea.application.token, user.email, user.name)
  end

  let(:idea) { Idea.make! }
  let(:user) { User.make! }
  let(:customer) { Customer.make! }
  let(:comment) { Comment.make! idea: idea }
  let(:new_comment_params) { { email: user.email, token: idea.application.token }.merge!(shared_params) }
  let(:new_comment_params_with_info) { { info: info_param }.merge!(shared_params) }
  let(:params) { new_comment_params.merge!({ id: comment.id }) }
  let(:params_with_info) { new_comment_params_with_info.merge!({id: comment.id}) }

  context 'as widget user' do
    before do
      user.widgets << idea.application
    end

    describe '#create' do
      after { expect(response).to render_template(:show) }

      example 'with email and token params' do
        expect do
          post :create, new_comment_params.except!(:id)
        end.to change { Comment.count }.by(1)
      end

      example 'with info param' do
        expect do
          post :create,
               new_comment_params_with_info
        end.to change { Comment.count }.by(1)
      end
    end

    describe '#update' do
      context 'can update own comment' do
        before { comment.update_attributes creator: user }
        after { expect(response.status).to eq(200) }

        it 'with email and token params' do
          expect { put :update, params }.to change { comment.reload.body }.from(comment.body).to('new body tekst')
        end

        it 'with info params' do
          expect { put :update, params_with_info }.to change { comment.reload.body }.from(comment.body).to('new body tekst')
        end
      end

      context 'cannot update others comments' do
        after { expect(response.status).to eq(403) }

        it 'with email and token params' do
          put :update, params
        end

        it 'with info params' do
          put :update, params_with_info
        end
      end

      context 'with invalid comment paramaters' do
        before do
          comment.update_attributes creator: user
          params[:comment] = { body: nil }
          put :update, params
        end

        it 'fails' do
          expect(response.status).to eq(422)
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

  context 'widget user of another widget' do
    context '#create' do
      it 'raises error' do
        expect{ put :create, params }.to raise_error(NoAccessException)
      end
    end

    context '#update' do
      it 'raises error with email and token params' do
        expect { put :update, params }.to raise_error(NoAccessException)
      end

      it 'raises error with info params' do
        expect { put :update, params_with_info }.to raise_error(NoAccessException)
      end
    end
  end
end
