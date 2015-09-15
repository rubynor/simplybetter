namespace :sb do
  desc 'Clean up DEMO app and add dummy data'
  task reset_demo_app: :environment do
    app = Application.find_by_token('DEMO')
    app.ideas.destroy_all
    customer = Customer.find_by_email('demo@simplybetter.io')

    ideas = [
      {title: "Show album covers in music tables", description: "It would be great if you could show the album covers in the music tables"},
      {title: "Create an android app with a feed", description: "Your website is my number one source of news, and i would really like to see an android app that can notify me whenever new articles have been published."},
      {title: "RSS support", description: "No explenation needed"},
      {title: "New logo?", description: "Your logo is sooo #{Time.now.yesterday.strftime('%D')}. It's time to change!"}
    ]

    comments = [
      "I like the general idea! Could you please elaborate?",
      "Yes, this is it!",
      "I share your view on this, but i think it would be better if we added bluetooth",
      "Everything is better with bluetooth",
      "How come?",
      "This will require tremendous effort from the dev team, but we will start working on it right away!",
      "Best idea ever!",
      "I think this can be solved differently",
      "Joe, where do you stand on this?",
      "Perhaps we should start a kickstarter campaign to make this happen",
      "I have a feeling that this could revolutionize the world",
      "I like this idea. I will have a talk with the board",
      "There is already an app that solves this",
      "If this was true, i would definitely be interested",
      "There is one side effect though, if we implement this some parts of the application will no longer be useful",
      "You are on to something here",
      "What if we change it up a little, and use the second approach in stead?",
      "This could solve a lot of my problems",
      "We'll add this to our roadmap",
    ]

    # TODO: Add some real text to make the Demo app more legit
    idea = customer.ideas.create!(title: ideas[-1][:title], description: ideas[-1][:description], application_id: app.id)
    users = app.users
    users.each_with_index do |u, n|
      puts ideas[n][:title]
      i = u.ideas.create! title: ideas[n][:title], description: ideas[n][:description], application_id: app.id, completed: n == 1
      comment_text = comments.delete_at(Random.rand(comments.length))
      comment = idea.comments.create! body: comment_text, creator_id: u.id, creator_type: 'User'
      vote = u.votes.create!(value: 99, vote_receiver: idea)
      Notification.create_with(action: comment, subject: idea, recipient: idea.creator, app_id: app.id) if n == 0
      Notification.create_with(action: vote, subject: idea, recipient: idea.creator, app_id: app.id ) if n == 2
    end

    users.each do |u|
      app.ideas.all.each do |i|
        comment_text = comments.delete_at(Random.rand(comments.length))
        u.votes.create!(value: rand(1000), vote_receiver: i)
        i.comments.create! body: comment_text, creator_id: u.id, creator_type: 'User'
      end
    end
  end
end
