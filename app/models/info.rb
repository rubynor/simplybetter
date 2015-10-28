class Info < ActiveRecord::Base
  has_many :notifications, as: :subject, dependent: :destroy

  validates :body, :route, presence: true

  # This metod is a helper to create notifications to customers
  def self.create_and_notify_customers(text:, route:, external: false)
    info = Info.create!(body: text, route: route, external: external)
    sb = Customer.find_by_email('support@simplybetter.io')
    Application.all.each do |app|
      app.customers.each do |c|
        Notification.create!(subject: info, action: info, recipient: c, action_attribute_changed_by: sb, application_id: app.id)
      end
    end
  end

  def notification_text(_recipient, **_args)
    [ { bold: 'Info:', normal: body, url: 'settings' } ]
  end

  def notification_url
    { route: self.route, external: self.external? }
  end
end
