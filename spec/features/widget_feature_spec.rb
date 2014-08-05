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
      click_link 'My widget'
    end
    example 'comment an idea' do
      within_frame 0 do
        title = Idea.first.title
        page.should have_content title
        first('h1', text: title).click
        fill_in 'Leave a comment...', with: 'My new comment'
        click_button 'OK'
        page.should have_content('My new comment')
        find_field('Leave a comment...').value.should_not eq('My new comment')
      end
    end
    example 'new idea' do
      within_frame 0 do
        fill_in 'title-input', with: 'Idea'
        fill_in 'Description', with: 'My idea description'
        click_button 'send'
        page.should have_css('.comment-body')
      end
    end
    example 'edit idea' do
      within_frame 0 do
        page.should have_content '[edit idea]'
        first('a', text: '[edit idea]').click
        page.should_not have_css('.comment-body')
        fill_in 'title-input', with: 'New text for title'
        click_button 'send'
        page.should have_css('.comment-body')
        page.should have_content('New text for title')
      end
    end
    example 'up vote' do
      within_frame 0 do
        page.should have_css '.up'
        first('.up').click
        page.should have_css '.active'
      end
    end
    example 'down vote' do
      within_frame 0 do
        page.should have_css '.down'
        first('.down').click
        page.should have_css '.active'
      end
    end
    example 'mark notification as read' do
      within_frame 0 do
        Notification.last.checked.should eq(nil)
        page.should_not have_content 'Notifications'
        page.should have_css '.new-notifications'
        first('.new-notifications').click
        page.should have_css '.new'
        first('.new').click
        Notification.last.checked.should eq(true)
      end
    end
    example 'navigation' do
      within_frame 0 do
        title = Idea.first.title
        page.should have_content title
        first('h1', text: title).click
        page.should have_content 'BACK'
        first('.back-arrow').click
        page.should_not have_content 'BACK'
      end
    end

    context 'settings page' do
      before do
        within_frame 0 do
          first('.settings-button').click
        end
      end

      example 'update name' do
        within_frame 0 do
          fill_in 'user_name', with: 'Cool Person'
          click_button 'Save'
          page.should have_css('.success')
        end
      end

      example 'unsubscribe from emails' do
        within_frame 0 do
          check 'unsubscribe'
          page.should have_css('.unsubscribed')
          uncheck 'unsubscribe'
          page.should have_css('.subscribed')
        end
      end
    end
  end

end
