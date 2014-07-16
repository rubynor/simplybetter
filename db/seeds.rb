# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do
  customer = Customer.create!(email: 'lol@lol.com', name: 'Development user', password: 'dev', password_confirmation: 'dev')
  app = customer.applications.create!(name: 'Development Application', intro: 'A small description here')
  app.update_attributes!(token: 'BYGKGJYA')
  puts 'Created customer: lol@lol.com with password: dev'
  idea = Idea.create! title: 'Test', description: 'En liten beskrivelse', application_id: app.id, creator: customer
  puts 'Created an idea'
  user = User.create!(email: 'test@test.com', name: 'Arne', application_id: app.id)
  comment = Comment.create!(body: 'My comment', idea_id: idea.id, creator_id: user.id, creator_type: 'User')
  puts 'Created comment'
  Notification.create_with(action: comment, subject: idea, recipient: customer, app_id: app.id)
  puts 'Created notification'
end
