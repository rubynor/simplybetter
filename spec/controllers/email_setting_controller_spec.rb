require 'spec_helper'

describe EmailSettingsController do
  describe '#unsubscribe' do
    let(:email_setting) { EmailSetting.make! }
    it 'should unsubscribe the EmailSetting with the matching token' do
      expect(email_setting.unsubscribe_token.length).to be > 0
      expect do
        get :unsubscribe, unsubscribe_token: email_setting.unsubscribe_token
      end.to change { email_setting.reload.unsubscribed }.from(false).to(true)
    end

    it 'should assign message' do
      get :unsubscribe, unsubscribe_token: email_setting.unsubscribe_token
      expect(assigns(:message)).to eq('You have been unsubscribed from email notifications')
    end

    context 'wrong unsubscribe_token' do
      it 'should do nothing' do
        expect do
          get :unsubscribe, unsubscribe_token: 'bad_token'
        end.to_not change { email_setting.reload.unsubscribed }
      end

      it 'assigns error message' do
        get :unsubscribe, unsubscribe_token: 'bad_token'
        expect(assigns(:message)).to eq('Unfortunately we could not unsubscribe you. Your link might be expired')
      end
    end
  end
end
