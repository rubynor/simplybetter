class UserNotifier < ActionMailer::Base
  extend MailerHelpers
  default from: 'support@simplybetter.io'

  def self.notify_group_comment(group, comment)
    idea = comment.idea
    group.each do |u|
      if should_send_mail?(u, comment.creator)
        new_comment(u, comment.creator, comment, idea).deliver
      end
    end
  end

  def new_comment(receiver, creator, comment, idea)
    @creator = creator
    @comment = comment
    @receiver = receiver
    @idea = idea

    subject = "SimplyBetter: New comment on the idea: '#{@idea.title}'"

    mail to: @receiver.email, subject: subject
  end

  def self.notify_group_completed(group, creator, idea)
    group.each do |u|
      if should_send_mail?(u, creator)
        idea_completed(u, creator, idea).deliver
      end
    end
  end

  def idea_completed(receiver, creator, idea)
    @creator = creator
    @idea = idea
    @receiver = receiver

    subject = if @receiver == idea.creator
                'SimplyBetter: Your idea has been implemented'
              else
                'SimplyBetter: An idea you commented has been implemented'
              end

    mail to: @receiver.email, subject: subject
  end
end
