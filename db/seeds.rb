require "faker"
require "open-uri"

def get_mtl_addresses_from_json(quantity = nil, format = 'string')
  require 'json'

  filename = './mtl_addresses_complete.json'
  path_to_file = File.join(File.dirname(__FILE__), filename)

  error_message = "ERROR: cannot find #{filename}. Make sure it's in the same folder as seeds.rb"
  raise error_message unless File.exist?(path_to_file)

  addresses = JSON.parse(File.read(path_to_file))
  return quantity ? addresses.sample(quantity) : addresses unless format == 'string'

  addresses.map do |address|
    "#{address['number']} #{address['street']}, #{address['city']}, #{address['place']}, #{address['country']}"
  end
end

ADDRESS = get_mtl_addresses_from_json(50)
pp ADDRESS.first


REVIEW_CONTENT = ["Amazing person, very nice and gentle", "Great partner to learn from, patient but ruthless",
                  "Cannot ask for a better partner", "S.A.V.A.G.E.", "Showed up late but very good partner",
                  "Learned new techniques and some BJJ etiquette, very informative partner"].freeze

p "Destroying chatrooms and messages"
Message.destroy_all
Chatroom.destroy_all
p "Destroying all your users..."
User.destroy_all
p "Creating new users..."

ricky = User.new(
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
  belt: "None",
  training_style: "No-gi"
)
file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669766488/ricky_fbqus7.jpg")
ricky.photo.attach(io: file, filename: "jon.png", content_type: "image/png")
ricky.save

laura = User.new(
  email: "laura.gonzalez@gmail.com",
  password: "123456",
  first_name: "Laura",
  last_name: "Gonzalez",
  weight: 55,
  height: 164,
  address: "5333 Casgrain",
  gender: "Female",
  belt: "Purple",
  years_of_experience: 6,
  description: "BJJ expert that will strangle you",
  training_style: "Both"
)
file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669766489/laura-gonzalez_eggbxn.jpg")
laura.photo.attach(io: file, filename: "jon.png", content_type: "image/png")
laura.save

tsunami = User.new(
  email: "tsunami.abi@gmail.com",
  password: "123456",
  first_name: "Touhami",
  last_name: "Abi",
  weight: 70,
  height: 175,
  address: "5333 Casgrain",
  gender: "Male",
  description: "Not a BJJ expert but give him a stick and he will Kendo you to the ground",
  years_of_experience: 0,
  belt: "None",
  training_style: "Gi"
)
file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669766492/touhami_fkztx4.jpg")
tsunami.photo.attach(io: file, filename: "jon.png", content_type: "image/png")
tsunami.save

jonathan = User.new(
  email: "jonathan.troupe@gmail.com",
  password: "123456",
  first_name: "Jonathan",
  last_name: "Troupe",
  weight: 62,
  height: 180,
  address: "4875 Dufferin",
  gender: "Male",
  belt: "Black",
  years_of_experience: 10,
  description: "The only way you'll make it out is in a body bag.",
  training_style: "Both"
)
file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669766489/jon_uvwasx.jpg")
jonathan.photo.attach(io: file, filename: "jon.png", content_type: "image/png")
jonathan.save

jimbo = User.new(
  email: "jim.b@gmail.com",
  password: "123456",
  first_name: "Jim",
  last_name: "B.",
  weight: 65,
  height: 173,
  address: "4875 Clearview",
  gender: "Male",
  belt: "Blue",
  years_of_experience: 10,
  description: "I love BJJ, want to share my knowledge and learn new things!",
  training_style: "Both"
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669936631/development/yhtjwc2g7mct4ugno86zidk4jrm3.jpg")
jimbo.photo.attach(io: file, filename: "jim.png", content_type: "image/png")
jimbo.save

hugh = User.new(
  email: "hugh.mungus@gmail.com",
  password: "123456",
  first_name: "Hugh",
  last_name: "Mungus",
  weight: 90,
  height: 190,
  address: ADDRESS.sample,
  gender: "Male",
  belt: "Black",
  years_of_experience: 8,
  description: "Experienced BBJ practitioner, loved martial arts since I was 5.",
  training_style: "Both"
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669941271/Hugh_Mungus_s2jxdh.png")
hugh.photo.attach(io: file, filename: "jim.png", content_type: "image/png")
hugh.save

claire = User.new(
  email: "claire.grifter@gmail.com",
  password: "123456",
  first_name: "Claire",
  last_name: "Grifter",
  weight: 60,
  height: 150,
  address: ADDRESS.sample,
  gender: "Female",
  belt: "Blue",
  years_of_experience: 4,
  description: "I'm still new to BJJ but I am getting the hang of these leg locks!",
  training_style: "Both"
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669941601/Claire_Grifter_tvgyya.png")
claire.photo.attach(io: file, filename: "jim.png", content_type: "image/png")
claire.save
p "Users created successfully."

ben = User.new(
  email: "ben.dover@gmail.com",
  password: "123456",
  first_name: "Ben",
  last_name: "Dover",
  weight: 85,
  height: 185,
  address: ADDRESS.sample,
  gender: "Male",
  belt: "Brown",
  years_of_experience: 8,
  description: "I've tried several martial arts but I think BJJ might be the most fun and versatile!",
  training_style: "Both"
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669941600/Ben_Dover_fqa5gn.png")
ben.photo.attach(io: file, filename: "jim.png", content_type: "image/png")
ben.save

kaylee = User.new(
  email: "kaylee.rider@gmail.com",
  password: "123456",
  first_name: "Kaylee",
  last_name: "Rider",
  weight: 62,
  height: 173,
  address: ADDRESS.sample,
  gender: "Female",
  belt: "Black",
  years_of_experience: 9,
  description: "This is not a staring contest. I will stare into your soul and bring fear to my opponents as I make
                them tap out before they even realize what happened to them.",
  training_style: "Both"
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669941600/Kaylee_Rider_mrrcaa.png")
kaylee.photo.attach(io: file, filename: "jim.png", content_type: "image/png")
kaylee.save

tiffany = User.new(
  email: "tiffany.smith@gmail.com",
  password: "123456",
  first_name: "Tiffany",
  last_name: "Smith",
  weight: 58,
  height: 142,
  address: ADDRESS.sample,
  gender: "Female",
  belt: "Blue",
  years_of_experience: 5,
  description: "I used to do gymnastics before so my flexibility helps me a lot when it comes to
                escaping submissions and tricking my opponent.",
  training_style: "Both"
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669941600/Tiffany_Smith_gufdos.png")
tiffany.photo.attach(io: file, filename: "jim.png", content_type: "image/png")
tiffany.save

p "Users created successfully."
p "Clearing out events, guests, partner requests and reviews"
Event.destroy_all
Guest.destroy_all
Review.destroy_all
Partner.destroy_all
p "Creating new events, guests, partner requests and reviews"

park1 = "https://res.cloudinary.com/dr82gggzf/image/upload/v1669766488/park1_bxndwu.jpg"
park2 = "https://res.cloudinary.com/dr82gggzf/image/upload/v1669766488/park2_b7fgrz.jpg"
gym1 = "https://res.cloudinary.com/dr82gggzf/image/upload/v1669766488/gym1_prtutu.jpg"
dojo1 = "https://res.cloudinary.com/dr82gggzf/image/upload/v1669766488/dojo1_q7f5xv.jpg"

event_photos = [park1, park2, gym1, dojo1]

Review.create!(
  content: "He is a great partner, very patient, I really felt like he wanted me to improve my game. Also... Great tips on kimuras!",
  user_id: jimbo.id,
  writer_id: ricky.id,
  rating: 4
)

Review.create!(
  content: "Nice guy! to the next time.",
  user_id: jimbo.id,
  writer_id: jonathan.id,
  rating: 5
)

Review.create!(
  content: "Why not! Love Montreal and BJJ.",
  user_id: jimbo.id,
  writer_id: tsunami.id,
  rating: 5
)

Review.create!(
  content: REVIEW_CONTENT.sample,
  user_id: hugh.id,
  writer_id: ricky.id,
  rating: 3
)

Review.create!(
  content: REVIEW_CONTENT.sample,
  user_id: claire.id,
  writer_id: ricky.id,
  rating: 3
)

Review.create!(
  content: REVIEW_CONTENT.sample,
  user_id: ben.id,
  writer_id: ricky.id,
  rating: 1
)

Review.create!(
  content: REVIEW_CONTENT.sample,
  user_id: tiffany.id,
  writer_id: ricky.id,
  rating: 3
)

Review.create!(
  content: REVIEW_CONTENT.sample,
  user_id: kaylee.id,
  writer_id: ricky.id,
  rating: 2
)

event1 = Event.new(
  address: "5160 Gatineau",
  date: DateTime.now,
  status: "Open",
  host: tsunami,
  description: "Bring your mat, I destroyed mine with the power of my suplex.",
  title: "Evening BJJ at touhami's."
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669942865/Le_wargon_bootcamp_z2nuyf.png")
event1.photo.attach(io: file, filename: "event1.png", content_type: "image/png")
event1.save

event2 = Event.new(
  address: ricky.address,
  date: DateTime.now,
  status: "Open",
  host: ricky,
  description: "Let's wrestle like it's the 70's baby!",
  title: "BJJ with a disco twist."
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669943298/Disco_event_nigq0y.png")
event2.photo.attach(io: file, filename: "event2.png", content_type: "image/png")
event2.save

2.times do
  event = Event.new(
    address: ADDRESS.sample,
    date: DateTime.now,
    status: "Open",
    host: jonathan,
    description: Faker::Quote.matz,
    title: Faker::Games::DnD.city
  )
  event.photo.attach(io: URI.open(event_photos.sample), filename: "PhotoFor#{event.title}.png", content_type: "image/png")
  event.save
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

2.times do
  event = Event.new(
    address: ADDRESS.sample,
    date: DateTime.now,
    status: "Open",
    host: ricky,
    description: Faker::Quote.matz,
    title: Faker::Games::DnD.city
  )
  event.photo.attach(io: URI.open(event_photos.sample), filename: "PhotoFor#{event.title}.png", content_type: "image/png")
  event.save
  Guest.create!(
    event_id: Event.last.id,
    guest_id: [laura.id, tsunami.id, jonathan.id].sample,
    status: Guest::STATUS.sample
  )
  Review.create!(
    content: Faker::TvShows::AquaTeenHungerForce.quote,
    user_id: ricky.id,
    writer_id: [laura.id, tsunami.id, jonathan.id].sample,
    rating: 4
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

2.times do
  event = Event.new(
    address: ADDRESS.sample,
    date: DateTime.now,
    status: "Open",
    host: laura,
    description: Faker::Quote.matz,
    title: Faker::Games::DnD.city
  )
  event.photo.attach(io: URI.open(event_photos.sample), filename: "PhotoFor#{event.title}.png", content_type: "image/png")
  event.save
  Guest.create!(
    event_id: Event.last.id,
    guest_id: [jonathan.id, tsunami.id, ricky.id].sample,
    status: Guest::STATUS.sample
  )
  Review.create!(
    content: Faker::TvShows::AquaTeenHungerForce.quote,
    user_id: laura.id,
    writer_id: [ricky.id, tsunami.id, jonathan.id].sample,
    rating: 4
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

2.times do
  event = Event.new(
    address: ADDRESS.sample,
    date: DateTime.now,
    status: "Open",
    host: tsunami,
    description: Faker::Quote.matz,
    title: Faker::Games::DnD.city
  )
  event.photo.attach(io: URI.open(event_photos.sample), filename: "PhotoFor#{event.title}.png", content_type: "image/png")
  event.save
  Guest.create!(
    event_id: Event.last.id,
    guest_id: [laura.id, jonathan.id, ricky.id].sample,
    status: Guest::STATUS.sample
  )
  Review.create!(
    content: Faker::TvShows::AquaTeenHungerForce.quote,
    user_id: tsunami.id,
    writer_id: [laura.id, ricky.id, jonathan.id].sample,
    rating: 4
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

p "Creating real chatrooms and messages"

chat1 = Chatroom.create!(name: "private_#{ricky.id}_#{laura.id}_")
chat2 = Chatroom.create!(name: "private_#{ricky.id}_#{tsunami.id}_")
chat3 = Chatroom.create!(name: "private_#{ricky.id}_#{jonathan.id}_")
chat4 = Chatroom.create!(name: "private_#{laura.id}_#{tsunami.id}_")
chat5 = Chatroom.create!(name: "private_#{laura.id}_#{jonathan.id}_")
chat6 = Chatroom.create!(name: "private_#{tsunami.id}_#{jonathan.id}_")

5.times do
  Message.create!(
    content: Faker::Movies::StarWars.quote,
    chatroom_id: chat1.id,
    user_id: [ricky.id, laura.id].sample
  )
end

5.times do
  Message.create!(
    content: Faker::Movies::StarWars.quote,
    chatroom_id: chat2.id,
    user_id: [ricky.id, tsunami.id].sample
  )
end

5.times do
  Message.create!(
    content: Faker::Movies::StarWars.quote,
    chatroom_id: chat3.id,
    user_id: [ricky.id, jonathan.id].sample
  )
end

5.times do
  Message.create!(
    content: Faker::Movies::StarWars.quote,
    chatroom_id: chat4.id,
    user_id: [laura.id, tsunami.id].sample
  )
end

5.times do
  Message.create!(
    content: Faker::Movies::StarWars.quote,
    chatroom_id: chat5.id,
    user_id: [laura.id, jonathan.id].sample
  )
end

5.times do
  Message.create!(
    content: Faker::Movies::StarWars.quote,
    chatroom_id: chat6.id,
    user_id: [tsunami.id, jonathan.id].sample
  )
end

p "Created real chatrooms and messages"
