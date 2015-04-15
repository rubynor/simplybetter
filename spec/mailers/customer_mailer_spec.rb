require 'spec_helper'

describe CustomerMailer do
  describe 'password_reset' do
    let(:customer) { Customer.make! password_reset_token: 'kjklji' }
    let(:mail) { CustomerMailer.password_reset(customer) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Password Reset')
      expect(mail.to).to eq([customer.email])
      expect(mail.from).to eq(['noreply@simplybetter.io'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('we see that you forgot your password')
    end
  end

end
