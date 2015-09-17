require 'spec_helper'

describe WidgetController, js: true, type: :feature, order: :defined do
  include SessionHelper

  before(:all) { Rails.application.load_seed }

  describe 'widget' do

    before(:all) do
      @customer = Customer.find_by(email: 'lol@lol.com')
      @app = @customer.applications.first
    end

    before do
      login_as @customer
      visit preview_application_path(@app)
    end

    example 'comment an idea' do
      within_frame 0 do
        title = Idea.first.title
        expect(page).to have_content title
        first('h1', text: title).click
        fill_in 'Leave a comment...', with: 'My new comment'
        click_button 'OK'
        expect(page).to have_content('My new comment')
        expect(find_field('Leave a comment...').value).not_to eq('My new comment')
      end
    end
    example 'up vote' do
      within_frame 0 do
        expect(page).to have_css '.up'
        first('.up').click
        expect(page).to have_css '.active'
      end
    end
    example 'up vote single view' do
      within_frame 0 do
        title = Idea.last.title
        expect(page).to have_content title
        first('h1', text: title).click

        expect(page).to have_css '.up'
        if page.has_css?('.active')
          first('.up').click
          expect(page).not_to have_css '.active'
        else
          first('.up').click
          expect(page).to have_css '.active'
        end
      end
    end
    example 'mark notification as read' do
      within_frame 0 do
        expect(Notification.first.checked).to eq(nil)
        expect(page).not_to have_content 'Notifications'
        expect(page).to have_css '.new-notifications'
        first('.new-notifications').click
        expect(page).to have_css '.new'
        first('.new').click
        expect(Notification.first.checked).to eq(true)
      end
    end
    example 'new idea' do
      within_frame 0 do
        fill_in 'title-input', with: 'Idea'
        fill_in 'Description', with: 'My idea description'
        click_button 'send'
        expect(page).to have_css('.comment-body')
      end
    end
    example 'edit idea' do
      within_frame 0 do
        first('h1', text: @customer.ideas.first.title).click
        expect(page).to have_content '[edit idea]'
        first('a', text: '[edit idea]').click
        fill_in 'title-input', with: 'New text for title'
        click_button 'update'
        expect(page).to have_css('.comment-body')
        expect(page).to have_content('New text for title')
      end
    end
    example 'navigation' do
      within_frame 0 do
        title = Idea.first.title
        expect(page).to have_content title
        first('h1', text: title).click
        expect(page).to have_content 'BACK'
        first('.back-arrow').click
        expect(page).not_to have_content 'BACK'
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
          expect(page).to have_css('.success')
        end
      end

      example 'unsubscribe from emails' do
        within_frame 0 do
          check 'unsubscribe'
          expect(page).to have_css('.unsubscribed')
          uncheck 'unsubscribe'
          expect(page).to have_css('.subscribed')
        end
      end
    end
    pending 'example support message'
  end
end
