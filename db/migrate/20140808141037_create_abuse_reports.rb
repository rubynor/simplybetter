class CreateAbuseReports < ActiveRecord::Migration
  def change
    create_table :abuse_reports do |t|
      t.association :abuse_reportable, polymorphic: true
      t.association :reporter, polymorphic: true
      t.text :reason

      t.timestamps
    end
  end
end
