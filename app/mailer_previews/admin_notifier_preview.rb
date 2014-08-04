class AdminNotifierPreview < ActionMailer::Preview
  def send_to_group
    customer = Customer.all.limit(2)
    idea = Idea.last
    creator = idea.creator
    AdminNotifier.send_to_group(customer, creator, idea)
  end
end
