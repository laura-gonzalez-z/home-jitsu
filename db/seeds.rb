require "faker"

ADDRESS = ["2054 Claremont", "4300 de Maisonneuve", "5120 Earnscliffe", "2121 St-Mathieu",
           "2255 St-Mathieu", "2125 St-Marc", "7205 d'Iberville", "2100 St-Marc", "5051 Clanranald",
           "5015 Clanranald", "4454 Coolbrook", "5881 Monkland", "2250 Guy", "1680 Lincoln",
           "6565 Kildare", "5755 Sir Walter Scott", "7460 Kingsley", "7461 Kingsley", "6950 Fielding",
           "5501 Adalbert", "625 Milton", "3474 Hutchison", "3655 Papineau", "1111 Mistral", "1101 Rachel E"].freeze

p "Destroying all your users..."
User.destroy_all
p "Creating new users..."

ricky = User.create!(
  email: "ricky.tran@gmail.com",
  password: "123456",
  first_name: "Ricky",
  last_name: "Tran",
  weight: 55,
  height: 173,
  address: "418 Claremont",
  gender: "Male",
  description: "Martial Arts Prodigy",
  years_of_experience: 0,
  belt: "None"
)

laura = User.create!(
  email: "laura.gonzalez@gmail.com",
  password: "123456",
  first_name: "Laura",
  last_name: "Gonzalez",
  weight: 40,
  height: 168,
  address: "5333 Casgrain",
  gender: "Female",
  belt: "Purple",
  years_of_experience: 6,
  description: "BJJ expert that will strangle you"
)

tsunami = User.create!(
  email: "tsunami.abi@gmail.com",
  password: "123456",
  first_name: "Touhami",
  last_name: "Abi",
  weight: 60,
  height: 175,
  address: "5160 Gatineau",
  gender: "Male",
  description: "Not a BJJ expert but give him a stick and he will Kendo you to the ground",
  years_of_experience: 0,
  belt: "None"
)

jonathan = User.create!(
  email: "jonathan.troupe@gmail.com",
  password: "123456",
  first_name: "Jonathan",
  last_name: "Troupe",
  weight: 52,
  height: 180,
  address: "4875 Dufferin",
  gender: "Male",
  belt: "Black",
  years_of_experience: 40,
  description: "The only way you'll make it out is in a body bag."
)

ADDRESS.each do |address|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create!(
    address:,
    belt: User::BELTS.sample,
    first_name:,
    last_name:,
    weight: (40..100).to_a.sample,
    height: (100..250).to_a.sample,
    gender: User::GENDERS.sample,
    years_of_experience: (0..20).to_a.sample,
    email: "#{first_name}.#{last_name}@gmail.com",
    password: "123456"
  )
end

p "Users created successfully."

p "Clearing out events"
Event.destroy_all
p "Creating new events"

5.times do
  Event.create!(
    date: DateTime.now,
    status: "Open",
    host: jonathan,
    description: Faker::Quote.matz,
    title: Faker::Games::DnD.city,
    photo: "Probably not needed placeholder"
  )
end

5.times do
  Event.create!(
    date: DateTime.now,
    status: "Open",
    host: ricky,
    description: Faker::Quote.matz,
    title: Faker::Games::DnD.city,
    photo: "Probably not needed placeholder"
  )
end

5.times do
  Event.create!(
    date: DateTime.now,
    status: "Open",
    host: laura,
    description: Faker::Quote.matz,
    title: Faker::Games::DnD.city,
    photo: "Probably not needed placeholder"
  )
end

5.times do
  Event.create!(
    date: DateTime.now,
    status: "Open",
    host: tsunami,
    description: Faker::Quote.matz,
    title: Faker::Games::DnD.city,
    photo: "Probably not needed placeholder"
  )
end

p "Created events"
