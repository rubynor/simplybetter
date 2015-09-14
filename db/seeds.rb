# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do
  customer = Customer.create!(email: 'lol@lol.com', name: 'Development user', password: 'dev', password_confirmation: 'dev', superadmin: true)
  app = customer.applications.create!(name: 'Development Application', intro: 'A small description here')
  app.update_attributes!(token: 'BYGKGJYA')
  puts 'Created customer: lol@lol.com with password: dev'
  idea = Idea.create! title: 'Test ide her', description: 'En liten beskrivelse', application_id: app.id, creator: customer
  puts 'Created an idea'
  user = app.users.create!(email: 'test@test.com', name: 'Arne')
  puts 'Created a user'
  comment = Comment.create!(body: 'My comment', idea_id: idea.id, creator_id: user.id, creator_type: 'User')
  puts 'Created comment'
  Notification.create_with(action: comment, subject: idea, recipient: customer, app_id: app.id)
  puts 'Created notification'
  Idea.create! title: 'En ny ide', description: 'En liten beskrivelse', application_id: app.id, creator: user

  unless ENV["RAILS_ENV"] == 'test'
    # Create some more test ideas and comments
    3.times do |n|
      app.users.create!(email: Faker::Internet.email, name: Faker::Name.name)
    end
    User.all.each do |u|
      i = Idea.create! title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, application_id: app.id, creator: u
      c = Idea.last.comments.create! body: Faker::Lorem.sentence, creator_id: u.id, creator_type: 'User'
      Notification.create_with(action: c, subject: i, recipient: i.creator, app_id: app.id)
    end
    Idea.last.update_attributes! completed: true
    Idea.all[-2].update_attributes! visible: false
    customer = Customer.create!(email: Faker::Internet.email, name: Faker::Name.name, password: 'dev', password_confirmation: 'dev')
    app = customer.applications.create!(name: Faker::Lorem.sentence, intro: Faker::Lorem.sentence)
    user = app.users.create!(email: Faker::Internet.email, name: Faker::Name.name)
    i = Idea.create! title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, application_id: app.id, creator: user
    c = i.comments.create! body: Faker::Lorem.sentence, creator_id: user.id, creator_type: 'User'
  end

  customer = Customer.create! name: 'Guest User', email: 'demo@simplybetter.io', password: 'dev', password_confirmation: 'dev'
  puts 'created customer demo@simplybetter.io with password dev'
  app = customer.applications.create! name: 'Demo', intro: 'Try out SimplyBetter here', icon: 'none'
  app.token = 'DEMO'
  app.save
  puts 'added DEMO application'

  3.times do |n|
    app.users.create!(email: "demo#{n}@simplybetter.io", name: Faker::Name.name)
  end
  Rake::Task['sb:reset_demo_app'].invoke unless Rails.env.test?

  Idea.reindex if Rails.env.development?
end

