class MigrateUserAndCustomerEmailSettings < ActiveRecord::Migration
  def up
    User.all.each do |user|
      unless user.email_setting
        EmailSetting.create!(mailable: user)
      end
    end
    Customer.all.each do |customer|
      unless customer.email_setting
        EmailSetting.create!(mailable: customer)
      end
    end
  end
  def down
    # ignore
  end
end
