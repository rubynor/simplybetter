class MigrateUserData < ActiveRecord::Migration
  def up
    User.all.each do |user|
      app = Application.find(user.application_id)
      user.applications << app
    end
  end

  def down
    User.all.each do |user|
      app = user.applications.first
      if app
        user.update_attributes!(application_id: app.id)
      end
    end
  end
end
