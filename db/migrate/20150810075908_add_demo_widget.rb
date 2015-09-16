class AddDemoWidget < ActiveRecord::Migration
  def up
    customer = Customer.create! name: 'Guest User', email: 'demo@simplybetter.io', password: 'dev', password_confirmation: 'dev'
    puts 'created customer demo@simplybetter.io with password dev'
    app = customer.applications.create! name: 'Demo', intro: 'Try out SimplyBetter here', icon: 'none', owner: customer
    app.token = 'DEMO'
    app.save
    puts 'added DEMO application'

    3.times do |n|
      app.users.create!(email: "demo#{n}@simplybetter.io", name: Faker::Name.name)
    end
    Rake::Task['sb:reset_demo_app'].invoke
  end

  def down
    Customer.find_by_email('demo@simplybetter.io').try(:destroy)
    puts 'destroyed user demo@simplybetter.io'
    a = Application.find_by_token('DEMO').try(:destroy)
    a.ideas.destroy_all if a
    puts 'destroyed demo application'
  end
end
