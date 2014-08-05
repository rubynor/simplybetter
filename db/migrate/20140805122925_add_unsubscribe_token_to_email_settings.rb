class AddUnsubscribeTokenToEmailSettings < ActiveRecord::Migration
  def up
    add_column :email_settings, :unsubscribe_token, :string

    EmailSetting.all.each do |setting|
      setting.set_email_unsubscribe_token
      setting.save!
    end
  end

  def down
    remove_column :email_settings, :unsubscribe_token, :string
  end
end
