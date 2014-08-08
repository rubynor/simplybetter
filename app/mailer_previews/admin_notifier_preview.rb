class AdminNotifierPreview < ActionMailer::Preview
  def new_idea
    receiver = Customer.last
    idea = Idea.last
    creator = idea.creator
    AdminNotifier.new_idea(receiver, creator, idea)
  end
end
