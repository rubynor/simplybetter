# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

c = Customer.create(token: 'beefbabeb33fb4b3')

f = Feature.create(title: 'Develop a natural and healthy energy bar', description:'At the same time, we want to inspire people and improve the World. This is our philosophy.', customer: c )

f.votes.create!(creator_email: "oc@foo.mu", value: -1, feature: f )
f.votes.create!(creator_email: "oc@foo.com", value: 2, feature: f )