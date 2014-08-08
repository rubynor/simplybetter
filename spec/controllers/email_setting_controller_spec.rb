require 'spec_helper'

describe EmailSettingsController do
  describe '#unsubscribe' do
    let(:email_setting) { EmailSetting.make! }
    it 'should unsubscribe the EmailSetting with the matching token' do
      expect(email_setting.unsubscribe_token.length).to be > 0
      expect do
        get :unsubscribe, unsubscribe_token: email_setting.unsubscribe_token
      end.to change{ email_setting.reload.unsubscribed }.from(false).to(true)
    end

    context 'wrong unsubscribe_token' do
      it 'should do nothing' do
        expect do
          get :unsubscribe, unsubscribe_token: "bad_token"
        end.to_not change{ email_setting.reload.unsubscribed }
      end
    end
  end
end
