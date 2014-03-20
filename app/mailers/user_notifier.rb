class UserNotifier < ActionMailer::Base
  default from: "noreply@simplybetter.io"

  def self.notify_group(group)
    group.each do |u|
      unless u.email == self.creator.email
        new_comment(u,self.creator,self).deliver
      end
    end
  end

  def new_comment(receiver, creator, comment)
    @creator = creator
    @comment = comment
    @idea = @comment.idea
    
    subject = 'SimplyBetter: A user made a comment on an idea you commented on'
    if @creator == receiver
      subject = 'SimplyBetter: A user commented on your idea'
    end

    mail to: receiver.email, subject: subject
  end
end
