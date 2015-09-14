require 'spec_helper'

describe 'Customization', js: true, type: :feature do
  include SessionHelper
  before { login_as_customer }

  describe 'customize' do
    it 'display the customzation page' do
      visit applications_path
      click_link 'Customization'
      expect(page).to have_content 'Select icon style'
    end
  end
end
