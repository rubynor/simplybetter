require 'spec_helper'

describe SupportMessage do

  before do
    @user = User.make!
    @application = Application.make!(users: [@user], customers: [Customer.make!,Customer.make!])
  end

  it "sets sent_at when message sent" do
    Timecop.freeze
    msg = SupportMessage.new(user: @user, application: @application, message: "this is a message")
    expect(msg.save_and_send).to eq(true)
    expect(msg.to).to match(/customer-\d+@example.com,customer-\d+@example.com/)
    expect(msg.from).to match(/user-\d+@machinist.com/)
    expect(msg.sent_at).to eq(Time.now)
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(ActionMailer::Base.deliveries.first.body).to eq("this is a message")
  end

  it "should invalidate" do
    msg = SupportMessage.new(user: @user, application: @application, message: nil)
    expect(msg.save_and_send).to eq(false)
    expect(msg.errors.count).to eq(1)
    expect(ActionMailer::Base.deliveries.count).to eq(0)
  end
end
