namespace :sb do
  desc 'Clean up DEMO app and add dummy data'
  task reset_demo_app: :environment do
    app = Application.find_by_token('DEMO')
    app.ideas.destroy_all
    customer = Customer.find_by_email('demo@simplybetter.io')

    # TODO: Add some real text to make the Demo app more legit
    idea = customer.ideas.create!(title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, application_id: app.id)
    users = app.users
    users.each_with_index do |u, n|
      i = u.ideas.create! title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, application_id: app.id, completed: n == 1
      comment = idea.comments.create! body: Faker::Lorem.sentence, creator_id: u.id, creator_type: 'User'
      vote = u.votes.create!(value: 99, vote_receiver: idea)
      Notification.create_with(action: comment, subject: idea, recipient: idea.creator, app_id: app.id) if n == 0
      Notification.create_with(action: vote, subject: idea, recipient: idea.creator, app_id: app.id ) if n == 2
    end

    users.each do |u|
      app.ideas.all.each do |i|
        u.votes.create!(value: rand(1000), vote_receiver: i)
        i.comments.create! body: Faker::Lorem.sentence, creator_id: u.id, creator_type: 'User'
      end
    end
  end
end
