task :setup => :environment do
  customer = Customer.create!(email: "lol@lol.com", name: "Development user", password: "dev", password_confirmation: "dev")
  app = customer.applications.create!(name: "Development Application")
  app.update_attributes!(token: "BYGKGJYA")
  puts "Created customer: lol@lol.com with password: dev"
end