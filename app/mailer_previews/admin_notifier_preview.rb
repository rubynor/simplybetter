class AdminNotifierPreview < ActionMailer::Preview
  def send_to_group
    customer = Customer.all.limit(2)
    creator = User.last
    idea = Idea.last
    AdminNotifier.send_to_group(customer, creator, idea)
  end
end
