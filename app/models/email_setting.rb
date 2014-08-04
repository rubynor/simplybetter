class EmailSetting < ActiveRecord::Base
  belongs_to :mailable, polymorphic: true

  def self.find_or_create(mailable)
    where(mailable: mailable).first_or_create
  end
end
