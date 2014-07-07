require 'spec_helper'

describe SessionsController, js: true do

  before :all do
    Rails.application.load_seed
    puts Application.count
  end

  describe 'something' do
    before do
      visit root_path
      fill_in 'email', with: 'lol@lol.com'
      fill_in 'password', with: 'dev'
      click_button 'Sign in'
    end
    example 'sign in' do
      visit root_path
      page.find('#simplybetterActivateButton').click
      page.within_frame 'simplybetterIframe' do
        page.should have_content 'Test'
        first('.up').click
        first('h1', text: 'Test').click
        fill_in 'Leave a comment...', with: 'My comment'
        click_button 'OK'
      end
      Application.last.ideas.first.votes_count.should eq(1)
      Application.last.ideas.first.comments.count.should eq(1)
    end
  end

end
