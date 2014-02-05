class AddIntroToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :intro, :text
  end
end
