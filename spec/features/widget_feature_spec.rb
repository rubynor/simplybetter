require 'spec_helper'

describe WidgetController, js: true do

  before :all do
    Rails.application.load_seed
  end

  describe 'widget' do
    before do
      visit root_path
      fill_in 'email', with: 'lol@lol.com'
      fill_in 'password', with: 'dev'
      click_button 'Sign in'
      click_link 'Go to app'
    end
    example 'comment an idea' do
      title = Idea.first.title
      page.should have_content title
      first('h1', text: title).click
      fill_in 'Leave a comment...', with: 'My new comment'
      click_button 'OK'
      page.should have_content('My new comment')
      find_field('Leave a comment...').value.should_not eq('My new comment')
    end
    example 'new idea' do
      fill_in 'title-input', with: 'Idea'
      fill_in 'Description', with: 'My idea description'
      click_button 'send'
      page.should have_css('.comment-body')
    end
    example 'edit idea' do
      first('a', text: '[edit idea]').click
      page.should_not have_css('.comment-body')
      fill_in 'title-input', with: 'New text for title'
      click_button 'send'
      page.should have_css('.comment-body')
      page.should have_content('New text for title')
    end
    example 'up vote' do
      page.should have_css '.up'
      first('.up').click
      page.should have_css '.active'
    end
    example 'down vote' do
      page.should have_css '.down'
      first('.down').click
      page.should have_css '.active'
    end
    example 'mark notification as read' do
      Notification.last.checked.should eq(nil)
      page.should_not have_content 'Notifications'
      page.should have_css '.new-notifications'
      first('.new-notifications').click
      page.should have_css '.new'
      first('.new').click
      Notification.last.checked.should eq(true)
    end
    example 'navigation' do
      title = Idea.first.title
      page.should have_content title
      first('h1', text: title).click
      page.should have_content 'BACK'
      first('.back-arrow').click
      page.should_not have_content 'BACK'
    end
  end

end
