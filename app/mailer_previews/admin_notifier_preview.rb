class AdminNotifierPreview < ActionMailer::Preview
  def send_to_group
    customer = Customer.all.limit(2)
    idea = Idea.last
    AdminNotifier.send_to_group(customer, idea)
  end
end
