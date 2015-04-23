require 'spec_helper'

describe WidgetApi::ApplicationsController do
  include SessionHelper

  describe '#is_admin' do
    let!(:application) { Application.make! }
    let!(:customer) { Customer.make! }

    before do
      sign_in_customer(customer)
    end

    it 'returns true if user is a customer for the application' do
      application.customers << customer
      get :is_admin, token: application.token, format: :json
      expect(JSON.parse(response.body)).to eql({"is_admin" => true})
    end

    it 'returns false if user is not a customer for the application' do
      get :is_admin, token: application.token, format: :json
      expect(JSON.parse(response.body)).to eql({"is_admin" => false})
    end
  end
end
