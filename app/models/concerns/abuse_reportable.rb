module AbuseReportable
  extend ActiveSupport::Concern

  included do
    has_many :abuse_reports, as: :reportable, dependent: :destroy
  end
end
