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
end
