class AdminNotifier < ActionMailer::Base
  default from: "noreply@simplybetter.io"

  def send_to_group(group, creator, idea)
    group.each do |u|
      unless u == creator
        new_idea(u,creator, idea).deliver
      end
    end
  end
  
  def new_idea(receiver,creator,idea)
    @creator = creator
    @idea = idea

    mail to: receiver.email, subject: 'SimplyBetter: A new idea has been submitted!'
  end
end
