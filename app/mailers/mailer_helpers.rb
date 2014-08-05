module MailerHelpers
  def should_send_mail?(user, subject_creator_user)
    !one_who_triggered_notification?(user, subject_creator_user) &&
      !unsubscribed?(user)
  end

  def one_who_triggered_notification?(user, subject_creator_user)
    user == subject_creator_user
  end

  def unsubscribed?(user)
    EmailSetting.unsubscribed?(user)
  end
end
