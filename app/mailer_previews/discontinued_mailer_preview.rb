class DiscontinuedMailerPreview < ActionMailer::Preview
  def send_to_all
    DiscontinuedMailer.send_to_all()
  end
end