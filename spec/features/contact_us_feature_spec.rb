require 'spec_helper'

describe 'ContactUs', js: true, type: :feature do
  it 'sends a mail with message' do
    visit root_path
    fill_in 'name', with: 'My name'
    fill_in 'email', with: 'my@email.com'
    fill_in 'message', with: 'my message'
    click_button 'SEND'
    expect(page).to have_content('Thank you for your message, we will return to you as soon as possible')
  end
end
