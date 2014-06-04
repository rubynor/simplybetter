require 'spec_helper'

describe CustomerMailer do
  describe 'password_reset' do
    let(:customer) { Customer.make! password_reset_token: 'kjklji' }
    let(:mail) { CustomerMailer.password_reset(customer) }

    it 'renders the headers' do
      mail.subject.should eq('Password Reset')
      mail.to.should eq([customer.email])
      mail.from.should eq(['noreply@simplybetter.io'])
    end

    it 'renders the body' do
      mail.body.encoded.should match('To reset you password, click the URL below.')
    end
  end

end
