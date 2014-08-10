class AbuseReports < ActiveRecord::Base
  belongs_to :reportable, polymorphic: true
  belongs_to :reporter, polymorphic: true
end
