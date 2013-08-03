# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

customer = Customer.create!(name: 'Acme Inc', email: 'test@example.com', password: 'secret', password_confirmation: 'secret') 

application = customer.applications.create!(name: 'Howhard')

f1 = application.features.create!(title: 'Develop a natural and healthy energy bar', description:'At the same time, we want to inspire people and improve the World. This is our philosophy.')
f2 = application.features.create!(title: 'Develop a coconut energy bar', description:'Not too sweet!')

f1.votes.create!(voter_email: "oc@foo.mu", value: -1)
f1.votes.create!(voter_email: "oc@foo.com", value: 2)

Comment.create!(feature_id: f1.id, body: 'How hard can it be?', user_id: 1)
Comment.create!(feature_id: f1.id, body: 'How hard can it be again?', user_id: 1)
