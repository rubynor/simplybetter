class MigrateDefaultForSupport < ActiveRecord::Migration
  def change
    Application.all.map do |a|
      a.support_enabled = false
      a.save
    end
  end
end
