class UserNotifierPreview < ActionMailer::Preview
  def idea_completed
    creator = Customer.last
    receiver = User.last
    idea = Idea.first
    UserNotifier.idea_completed(receiver, creator, idea)
  end

  def new_comment
    idea = Idea.first
    comment = idea.comments.last
    creator = comment.creator
    receiver = User.first
    UserNotifier.new_comment(receiver, creator, comment, comment.idea)
  end
end
