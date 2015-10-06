require 'spec_helper'

describe 'Customer', js: true, type: :feature do
  include SessionHelper

  before(:all) { Rails.application.load_seed }

  describe 'register customer and create app' do
    it 'without choosing priceplan at first' do
      visit root_path
      click_link 'GET SIMPLY BETTER'
      fill_in 'customer_name', with: 'My name'
      fill_in 'customer_email', with: 'my@email.com'
      fill_in 'customer_password', with: 'mypassword'
      fill_in 'customer_password_confirmation', with: 'mypassword'
      fill_in 'customer_promotion_code', with: 'promocode'
      click_button 'CREATE ACCOUNT'
      expect(Customer.last.name).to eq('My name')
      expect(Customer.last.promotion_code).to eq('promocode')
      fill_in 'application_name', with: 'Test app'
      click_button 'create_app'
      expect(page).to have_content('Select icon style')
      expect(Application.last.price_plan_id).to eq(1)
    end

    it 'with choosing priceplan' do
      visit root_path
      within('.pk-white-box') do
        click_link 'CHOOSE'
      end
      fill_in 'customer_name', with: 'My name'
      fill_in 'customer_email', with: 'my2@email.com'
      fill_in 'customer_password', with: 'mypassword'
      fill_in 'customer_password_confirmation', with: 'mypassword'
      fill_in 'customer_promotion_code', with: 'promocode'
      click_button 'CREATE ACCOUNT'
      expect(Customer.last.name).to eq('My name')
      expect(Customer.last.promotion_code).to eq('promocode')
      fill_in 'application_name', with: 'Test app'
      click_button 'create_app'
      expect(page).to have_content('Select icon style')
      expect(Application.last.price_plan_id).to eq(2)
    end
  end
end
