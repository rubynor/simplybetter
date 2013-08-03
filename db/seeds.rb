# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

customer = Customer.create!(name: 'Acme Inc', email: 'test@example.com', password: 'secret', password_confirmation: 'secret') 

application = customer.applications.create!(name: 'Howhard')

f1 = application.features.create!(
    title: 'Develop a natural and healthy energy bar',
    description: "Lorizzle daahng dawg dolizzle sit gangsta, consectetuer adipiscing elit. Dizzle we gonna chung velizzle, crackalackin volutpizzle, gangsta quizzle, shit vizzle, i saw beyonces tizzles and my pizzle went crizzle. Pellentesque egizzle tortor. Fizzle bizzle. Shiznit izzle dizzle funky fresh mammasay mammasa mamma oo sa tempizzle crunk. Maurizzle pellentesque nibh izzle dope. For sure izzle tortor. Boofron yippiyo rhoncizzle sheezy. In funky fresh funky fresh shizzle my nizzle crocodizzle dictumst. Ma nizzle dapibizzle. Curabitur check out this urna, pretizzle eu, shiznit ac, eleifend vitae, nunc. Fo shizzle suscipit. Integizzle semper velit sizzle purus."
)
f2 = application.features.create!(
    title: 'Develop a coconut energy bar',
    description: "Curabitizzle izzle diam quizzle that's the shizzle for sure mollizzle. Suspendisse boofron. Dawg odio. Check it out neque. Phat orci. Crizzle mah nizzle doggy, interdizzle a, tellivizzle boofron amet, rizzle izzle, owned. Doggy gravida. Shizzlin dizzle nizzle mi, volutpizzle izzle, fizzle sizzle, bizzle semper, cool. Crizzle in daahng dawg. My shizz volutpat felis fo shizzle my nizzle orci. Crizzle crazy bizzle izzle purus fo shizzle my nizzle ornare. Nizzle check it out fo shizzle hizzle lacus. Nunc urna. Suspendisse venenatis placerizzle get down get down. Curabitizzle brizzle ante. Nunc pharetra, pot eu dapibus hendrerizzle, dope felizzle shut the shizzle up sizzle, dang aliquizzle magna fo shizzle phat hizzle. Dizzle a nisl. Class for sure taciti fizzle izzle gangster dang per conubia check it out, pizzle yo hymenizzle. interdizzle, that's the shizzle nizzle elementum nonummy, you son of a bizzle orci viverra , in semper risus arcu crunk mah nizzle."
)

f1.votes.create!(voter_email: "oc@foo.mu", value: -1)
f1.votes.create!(voter_email: "oc@foo.com", value: 2)

Comment.create!(feature_id: f1.id, body: 'How hard can it be?', user_id: 1)
Comment.create!(feature_id: f1.id, body: 'How hard can it be again?', user_id: 1)
