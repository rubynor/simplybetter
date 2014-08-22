module AbuseReporter
  extend ActiveSupport::Concern

  # Please include a reference to application from the model
  # you're including this in
  included do
    has_many :abuse_reports, as: :abuse_reporter, dependent: :destroy
  end
end
