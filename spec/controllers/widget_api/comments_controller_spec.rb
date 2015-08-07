require 'spec_helper'

describe WidgetApi::CommentsController do
  include SessionHelper
  let(:idea) { Idea.make! }
  let(:user) { User.make! }
  let(:customer) { Customer.make! }
  let(:info_param) { encode_to_base64(idea.application.token, user.email, user.name) }

  context 'widget user' do
    before do
      user.widgets << idea.application
    end

    describe 'adding a comment' do
      after do
        expect(response).to render_template(:show)
      end

      example 'with email and token params' do
        post :create, idea_id: idea.id, comment: { body: 'Oh, hi thar!', idea_id: idea.id }, email: user.email, token: idea.application.token, format: :json
      end

      example 'with info param' do
        post :create, idea_id: idea.id, comment: { body: 'Oh, hi thar!', idea_id: idea.id }, info: info_param, format: :json
      end
    end

    describe 'update comment' do
      describe 'own comment' do
        before do
          @comment = Comment.make!(idea: idea, creator: user)
        end
        example 'with email and token params' do
          expect do
            put :update, idea_id: idea.id, id: @comment.id, comment: { body: 'new body tekst' }, email: user.email, token: idea.application.token, format: :json
          end.to change { Comment.last.body }.from(@comment.body).to('new body tekst')
        end

        example 'with info param' do
          expect do
            put :update, idea_id: idea.id, id: @comment.id, comment: { body: 'new body tekst' }, info: info_param, format: :json
          end.to change { Comment.last.body }.from(@comment.body).to('new body tekst')
        end
      end

      describe "can't update other comments" do
        before do
          @comment = Comment.make!(idea: idea)
        end
        example 'with email and token params' do
          expect do
            put :update, idea_id: idea.id, id: @comment.id, comment: { body: 'new body tekst' }, email: user.email, token: idea.application.token, format: :json
          end.not_to change { Comment.last.body }
        end
        example 'with info param' do
          expect do
            put :update, idea_id: idea.id, id: @comment.id, comment: { body: 'new body tekst' }, info: info_param, format: :json
          end.not_to change { Comment.last.body }
        end
      end

      example 'admin - update visible' do
        sign_in_customer(Customer.make!)
        comment = Comment.make!(idea: idea)
        expect do
          put :update, idea_id: idea.id, id: comment.id, comment: { visible: false }, format: :json
        end.to change { Comment.last.visible }.from(true).to(false)
      end
    end
  end

  context "customer has not visited it's widget, thus is not part of customer.widgets" do
    example 'adding a comment' do
      customer.applications << idea.application
      sign_in_customer(customer)
      post :create, idea_id: idea.id, comment: { body: 'Oh, hi thar!', idea_id: idea.id }, format: :json
      expect(response).to render_template(:show)
    end
  end
end
