require 'spec_helper'

describe 'Customization', js: true, type: :feature do
  include SessionHelper

  before(:all) do
    @customer = Customer.make!(:with_apps)
    @app = @customer.applications.first
  end

  before do
    login_as @customer
    visit customization_application_path(@app)
  end

  it 'disables the application' do
    find(:css, '#disable-app').set(true)
    find(:css, '#customization-save').click
    expect(page).to have_content('Updated')
    expect(@app.reload.disabled).to be(true)
  end
end
