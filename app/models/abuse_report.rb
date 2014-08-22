class AbuseReport < ActiveRecord::Base
  belongs_to :abuse_reportable, polymorphic: true, inverse_of: :abuse_reports
  belongs_to :abuse_reporter, polymorphic: true, inverse_of: :abuse_reports
  belongs_to :application

  validates_presence_of :abuse_reportable, :abuse_reporter, :application

  scope :for, ->(application) { where(application_id: application.id) }
end
