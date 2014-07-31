require 'spec_helper'

describe WidgetController do

  before :all do
    @application = Application.make!
  end

  describe 'widget' do
    it 'should create a new user' do
      expect do
        get :widget, appkey: @application.token, email: 'test@test.com', name: 'My name'
      end.to change(User, :count).by(1)
    end

    it 'should not create a new user' do
      user = User.make!
      expect do
        get :widget, appkey: @application.token, email: user.email, name: user.name
      end.to_not change(User, :count)
    end
  end
end
