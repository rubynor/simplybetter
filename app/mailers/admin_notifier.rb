class AdminNotifier < ActionMailer::Base
  default from: "noreply@simplybetter.io"
  
  def new_idea(receiver,creator,idea)
    @creator = creator
    @idea = idea

    mail to: receiver.email, subject: 'SimplyBetter: A new idea has been submitted!'
  end
end
