class CreateAbuseReports < ActiveRecord::Migration
  def change
    create_table :abuse_reports do |t|
      t.references :abuse_reportable, polymorphic: true
      t.references :reporter, polymorphic: true
      t.text :reason

      t.timestamps
    end
  end
end
