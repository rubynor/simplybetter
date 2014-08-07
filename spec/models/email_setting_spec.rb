require 'spec_helper'

describe EmailSetting do
  context 'creating an email setting' do
    it 'should generate an unsubscribe token' do
      email_setting = EmailSetting.make!
      expect(email_setting.unsubscribe_token.length).to be > 0
    end
  end
end
