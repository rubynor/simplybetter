require 'spec_helper'

describe CustomerMailer do
  describe 'password_reset' do
    let(:customer) { Customer.make! password_reset_token: 'kjklji' }
    let(:mail) { CustomerMailer.password_reset(customer) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Password Reset')
      expect(mail.to).to eq([customer.email])
      expect(mail.from).to eq(['support@simplybetter.io'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('To reset you password, click the URL below.')
    end
  end

end
