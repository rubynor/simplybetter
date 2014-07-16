require 'spec_helper'

describe WidgetController, js: true do

  before :all do
    Rails.application.load_seed
    puts Application.count
    puts Notification.count
  end

  describe 'widget' do
    before do
      visit root_path
      fill_in 'email', with: 'lol@lol.com'
      fill_in 'password', with: 'dev'
      click_button 'Sign in'
      page.find('#simplybetterActivateButton').click
    end
    example 'comment an idea' do
      expect do
        page.within_frame 'simplybetterIframe' do
          page.should have_content 'Test'
          first('h1', text: 'Test').click
          fill_in 'Leave a comment...', with: 'My comment'
          click_button 'OK'
          page.should have_content('My comment')
        end
      end.to change(Application.last.ideas.first.comments, :count).by(1)
    end
    example 'new idea' do
      expect do
        page.within_frame 'simplybetterIframe' do
          fill_in 'title-input', with: 'Idea'
          fill_in 'Description', with: 'My idea description'
          click_button 'send'
          page.should have_css('.comment-body')
        end
      end.to change(Application.last.ideas, :count).by(1)
    end
    example 'up vote' do
      page.within_frame 'simplybetterIframe' do
        first('.up').click
      end
      expect(Application.last.ideas.first.votes_count).to eq(1)
    end
    example 'down vote' do
      page.within_frame 'simplybetterIframe' do
        first('.down').click
      end
      expect(Application.last.ideas.first.votes_count).to eq(-1)
    end
    example 'open notifications' do
      page.within_frame 'simplybetterIframe' do
        page.should_not have_content 'Notifications'
        first('.new-notifications').click
        page.should have_content 'Notifications'
      end
    end
    example 'mark notification as read' do
      Notification.last.checked.should eq(nil)
      page.within_frame 'simplybetterIframe' do
        page.should_not have_content 'Notifications'
        first('.new-notifications').click
        first('.new').click
      end
      Notification.last.checked.should eq(true)
    end
    example 'navigation' do
      page.within_frame 'simplybetterIframe' do
        first('h1', text: 'Test').click
        page.should have_content 'BACK'
        first('.back-arrow').click
        page.should_not have_content 'BACK'
      end
    end
  end

end
