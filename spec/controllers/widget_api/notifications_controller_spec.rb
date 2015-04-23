require 'spec_helper'

describe WidgetApi::NotificationsController do
  before do
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

    it 'scopes by application' do
      # TODO: Clean up. It's a bit messy, but the idea is to test that the
      # count scopes by application
      application2 = Application.make!(customers: [@customer])
      @customer.widgets << application2
      comment2 = Comment.make!
      comment3 = Comment.make!
      Notification.create_with(action: comment2, subject: comment2.idea, recipient: @customer, app_id: application2.id)
      Notification.create_with(action: comment3, subject: comment3.idea, recipient: @customer, app_id: application2.id)

      get :count, token: @application.token, user_email: @customer.email
      res = { count: 1 }.to_json
      expect(response.body).to eq(res)

      get :count, token: application2.token, user_email: @customer.email
      res = { count: 2 }.to_json
      expect(response.body).to eq(res)
    end

    it 'scopes by user type' do
      # A little hackish.. but I need to test where both a user and customer
      # with same id has notifications..
      user = User.find_by(id: @customer.id)
      unless user
        user = User.make!(id: @customer.id)
      end
      user.widgets << @application
      comment = Comment.make!
      Notification.create_with(action: comment, subject: comment.idea, recipient: user, app_id: @application.id)

      # Total notifications with id the same as customer and user is 2
      expect(Notification.where(recipient_id: user.id, checked: nil).count).to eq(2)

      # Notifications should be scoped by user type, so it should only
      # return 1 for this customer
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
