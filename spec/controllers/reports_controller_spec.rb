require 'spec_helper'

describe ReportsController do
  include SessionHelper

  describe 'overview' do

    describe 'not signed in' do
      it 'redirects to login page' do
        get :overview
        expect(response).to redirect_to(login_url)
      end
    end

    describe 'signed in' do
      before do
        @customer = Customer.make!
        @application = Application.make!(customers: [@customer], owner: @customer)
        sign_in_customer(@application.customers.first)
      end

      it 'is only available for superadmins' do
        get :overview
        expect(response).to redirect_to(applications_url)
      end

      describe 'as superadmin' do
        before do
          @customer.update_attributes! superadmin: true
          Application.make!
          get :overview
        end

        it 'assigns all apps as @apps' do
          expect(assigns[:apps]).to eq(Application.all)
        end
      end
    end
  end
end
