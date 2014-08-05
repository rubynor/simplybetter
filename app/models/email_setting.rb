class EmailSetting < ActiveRecord::Base
  belongs_to :mailable, polymorphic: true

  def self.unsubscribed?(mailable)
    find_or_create_by(mailable: mailable).unsubscribed
  end
end
