require 'spec_helper'

describe AbuseReportsController do
  include SessionHelper

  before do
    @customer = Customer.make!
    @application = Application.make! customers: [@customer]
    sign_in_customer(@customer)
  end

  describe 'index' do
    context 'given a legit application id' do
      it 'should assign @reports' do
        report = AbuseReport.make! application: @application
        get :index, application_id: @application.id, format: :json
        expect(assigns(:reports).first).to eql(report)
      end
    end
    context 'with no or wrong application_id' do
      it 'should return an empty array of ActiveRecord::Relation' do
        report = AbuseReport.make! application: Application.make
        get :index, application_id: @application.id, format: :json
        expect(assigns(:reports)).to be_a ActiveRecord::Relation
        expect(assigns(:reports).length).to eql(0)
      end
    end
  end
end
