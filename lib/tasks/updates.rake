namespace :sb do
  desc "Update votes from storing user relation by email, to using a polymorphic association"
  task update_votes: :environment do
    Vote.all.each do |v|
      if v.vote_receiver_type == "Feature"
        unless v.update_attributes(vote_receiver_type: "Idea")
          v.destroy!
          puts "Destroyed duplicate vote"
        else
          puts "Updated votes type"
        end
      end
    end

    Vote.all.each do |v|
      unless v.vote_receiver
        v.destroy!
        puts "Deleted vote with no vote receiver"
      end
    end

    Application.all.each do |a|
      a.ideas.each do |i|
        i.votes.each do |v|
          email = v.voter_email

          if a.customer.email == email
            user = a.customer
          end

          unless user
            user = a.users.find_by(email: email)
          end
          unless user
            puts "Vote #{v.id} does not seem to have a user"
          else
            v.voter = user
            v.save!
            puts "Vote #{v.id} now have a relation to a voter: #{user.name}"
          end
        end
      end
    end
  end

  desc "Add idea-subscribers from previous interactions"
  task add_subscriptions: :environment do 
    def subscribe_me(item)
      subscription = item.subscribe
      if subscription == "created"
        puts "Subscribed "
        puts item
      elsif subscription == "exists"
        puts "This subscription exists"
        puts item
      else
        puts "This subscription does not exist, nor was it created"
        puts item.inspect
      end
    end

    def clean_up_comments
      Comment.all.each do |c|
        tmp = Idea.find_by(id: c.idea_id)
        if tmp.blank?
          if c.destroy
            puts "Destroyed comment with missing relation to idea"
          end
        end
      end
    end

    clean_up_comments()

    Vote.all.each do |v|
      subscribe_me(v)
    end

    Comment.all.each do |c|
      subscribe_me(c)
    end

    Idea.all.each do |i|
      subscribe_me(i)
    end
  end


  desc "Migrate all customers applications over to the new join table"
  task migrate_customers: :environment do
    Application.all.each do |a|
      customer = Customer.find(a.customer_id)
      a.customers << customer
      a.save!
    end
  end
end
