class AdminNotifierPreview < ActionMailer::Preview
  def new_idea
    receiver = Customer.last
    idea = Idea.first
    creator = idea.creator
    AdminNotifier.new_idea(receiver, creator, idea)
  end
end
