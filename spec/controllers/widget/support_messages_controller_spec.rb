require 'spec_helper'

describe WidgetApi::SupportMessagesController do


  before do
    @user = User.make!
    @application = Application.make!(users: [@user], customers: [Customer.make!])
  end

  it "sends support message" do
    expect do
      post :create, user_email: @user.email, token: @application.token, support_message: {message: 'This is the support message'}, format: :json
    end.to change {SupportMessage.count }.by(1)
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(response).to be_success
  end
end
