class AbuseReport < ActiveRecord::Base
  belongs_to :reportable, polymorphic: true
  belongs_to :reporter, polymorphic: true

  validates_presence_of :reportable, :reporter
end
