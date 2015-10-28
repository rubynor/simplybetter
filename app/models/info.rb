class Info < ActiveRecord::Base
  has_many :notifications, as: :subject, dependent: :destroy

  validates :body, :route, presence: true

  def notification_text(_recipient, **_args)
    [ { bold: 'Info:', normal: body, url: 'settings' } ]
  end

  def notification_url
    { route: self.route, external: self.external? }
  end
end
