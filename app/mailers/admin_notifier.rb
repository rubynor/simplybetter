class AdminNotifier < ActionMailer::Base
  include MailerHelpers
  default from: 'noreply@simplybetter.io'

  def send_to_group(group, creator, idea)
    group.each do |u|
      if should_send_mail?(u, creator)
        new_idea(u,creator, idea).deliver
      end
    end
  end

  private

  def new_idea(receiver,creator,idea)
    @receiver = receiver
    @creator = creator
    @idea = idea

    mail to: @receiver.email, subject: 'SimplyBetter: A new idea has been submitted!'
  end
end
