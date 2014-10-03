require 'spec_helper'

describe WidgetApi::NotificationsController do
  before :all do
    @customer = Customer.make!
    @application = Application.make!(customers: [@customer])
    @customer.widgets << @application
    comment = Comment.make!
    Notification.create_with(action: comment, subject: comment.idea, recipient: @customer, app_id: @application.id)
  end

  describe 'count' do
    it 'returns notifications count' do
      get :count, token: @application.token, user_email: @customer.email
      res = { count: 1 }.to_json
      expect(response.body).to eq(res)
    end
  end

  describe 'index' do
    it 'assigns users notifications' do
      get :index, token: @application.token, user_email: @customer.email, format: :json
      expect(assigns(:notifications)).to eq(Notification.for(@customer, @application.id))
    end

    it 'raises ArgumentError if no application' do
      expect do
        get :index, token: 'kh', user_email: @customer.email, format: :json
      end.to raise_error(ArgumentError)
    end

    it 'raises NoUserException if no application' do
      expect do
        get :index, token: @application.token, user_email: 'nothing', format: :json
      end.to raise_error(NoUserException)
    end
  end
end
