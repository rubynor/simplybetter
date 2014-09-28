module CustomerUserShared
  extend ActiveSupport::Concern
  included do
    has_many :comments, as: :creator, inverse_of: :creator
    has_many :ideas, as: :creator
    has_many :votes, as: :voter
    has_many :support_messages, as: :user, inverse_of: :user
    has_one :email_setting, as: :mailable, dependent: :destroy

    after_create :create_email_setting

    validates :email,
              format: {
                  with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                  on: :create},
              uniqueness: true,
              presence: true

    private

    def create_email_setting
      EmailSetting.create!(mailable: self)
    end

  end
end
