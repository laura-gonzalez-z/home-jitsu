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
    address: address,
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

p "Clearing out events, guests, partner requests and reviews"
Event.destroy_all
Guest.destroy_all
Review.destroy_all
Partner.destroy_all
p "Creating new events, guests, partner requests and reviews"


5.times do
  Event.create!(
    address: ADDRESS.sample,
    date: DateTime.now,
    status: "open",
    host: jonathan,
    description: Faker::Quote.matz,
    title: Faker::Games::DnD.city,
  )
  Guest.create!(
    event_id: Event.last.id,
    guest_id: [laura.id, tsunami.id, ricky.id].sample,
    status: Guest::STATUS.sample
  )
  Review.create!(
    content: Faker::TvShows::AquaTeenHungerForce.quote,
    user_id: jonathan.id,
    writer_id: [laura.id, tsunami.id, ricky.id].sample,
    rating: 4
  )
  Partner.create!(
    requestee_id: jonathan.id,
    requester_id: User.all.ids.sample
  )
  Partner.create!(
    requester_id: jonathan.id,
    requestee_id: User.all.ids.sample
  )
end

5.times do
  Event.create!(
    address: ADDRESS.sample,
    date: DateTime.now,
    status: "open",
    host: ricky,
    description: Faker::Quote.matz,
    title: Faker::Games::DnD.city,
  )
  Guest.create!(
    event_id: Event.last.id,
    guest_id: [laura.id, tsunami.id, jonathan.id].sample,
    status: Guest::STATUS.sample
  )
  Review.create!(
    content: Faker::TvShows::AquaTeenHungerForce.quote,
    user_id: ricky.id,
    writer_id: [laura.id, tsunami.id, jonathan.id].sample,
    rating: 5
  )
  Partner.create!(
    requestee_id: ricky.id,
    requester_id: User.all.ids.sample
  )
  Partner.create!(
    requester_id: ricky.id,
    requestee_id: User.all.ids.sample
  )
end

5.times do
  Event.create!(
    address: ADDRESS.sample,
    date: DateTime.now,
    status: "open",
    host: laura,
    description: Faker::Quote.matz,
    title: Faker::Games::DnD.city,
  )
  Guest.create!(
    event_id: Event.last.id,
    guest_id: [jonathan.id, tsunami.id, ricky.id].sample,
    status: Guest::STATUS.sample
  )
  Review.create!(
    content: Faker::TvShows::AquaTeenHungerForce.quote,
    user_id: laura.id,
    writer_id: [ricky.id, tsunami.id, jonathan.id].sample,
    rating: 5
  )
  Partner.create!(
    requestee_id: laura.id,
    requester_id: User.all.ids.sample
  )
  Partner.create!(
    requester_id: laura.id,
    requestee_id: User.all.ids.sample
  )
end

5.times do
  Event.create!(
    address: ADDRESS.sample,
    date: DateTime.now,
    status: "open",
    host: tsunami,
    description: Faker::Quote.matz,
    title: Faker::Games::DnD.city,
  )
  Guest.create!(
    event_id: Event.last.id,
    guest_id: [laura.id, jonathan.id, ricky.id].sample,
    status: Guest::STATUS.sample
  )
  Review.create!(
    content: Faker::TvShows::AquaTeenHungerForce.quote,
    user_id: tsunami.id,
    writer_id: [laura.id, ricky.id, jonathan.id].sample,
    rating: 5
  )
  Partner.create!(
    requestee_id: tsunami.id,
    requester_id: User.all.ids.sample
  )
  Partner.create!(
    requester_id: tsunami.id,
    requestee_id: User.all.ids.sample
  )
end

p "Created events, guests, partner requests and reviews for each user attached"
