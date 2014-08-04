class UserNotifier < ActionMailer::Base
  default from: 'noreply@simplybetter.io'

  def self.notify_group_comment(group, comment)
    group.each do |u|
      unless u.email == comment.creator.email
        new_comment(u, comment.creator, comment).deliver
      end
    end
  end

  def new_comment(receiver, creator, comment)
    @creator = creator
    @comment = comment
    @idea = @comment.idea

    subject = @creator == receiver ?
        'SimplyBetter: A user commented on your idea' :
        'SimplyBetter: A user made a comment on an idea you commented on'

    mail to: receiver.email, subject: subject
  end

  def self.notify_group_completed(group, creator, idea)
    group.each do |u|
      unless u.email == creator.email
        idea_completed(u, creator, idea).deliver
      end
    end
  end

  def idea_completed(receiver, creator, idea)
    @creator = creator
    @idea = idea

    subject = @creator == receiver ?
        'SimplyBetter: Your idea has been implemented' :
        'SimplyBetter: An idea you commented has been implemented'

    mail to: receiver.email, subject: subject
  end
end
