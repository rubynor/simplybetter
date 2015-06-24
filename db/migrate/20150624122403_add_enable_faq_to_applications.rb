class AddEnableFaqToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :faqs_enabled, :boolean, default: false, null: false
  end
end
