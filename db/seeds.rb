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
  years_of_experience: 4,
  description: "I love BJJ, want to share my knowledge and learn new things!",
  training_style: "Both"
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1670362468/jimbo_rv5b4c.jpg")
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

justin = User.new(
  email: "justin.smith@gmail.com",
  password: "123456",
  first_name: "Justin",
  last_name: "Thyme",
  weight: 75,
  height: 192,
  address: ADDRESS.sample,
  gender: "Male",
  belt: "Black",
  years_of_experience: 15,
  description: "I lost my hair because of a prank but it made me into a strong BJJ practitioner because your hands will
                slip on my head and I can use it as a tool to escape any submission.",
  training_style: "Both"
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669944330/Justin_Thime_p8jzw1.png")
justin.photo.attach(io: file, filename: "justin.png", content_type: "image/png")
justin.save

harry = User.new(
  email: "harry.smith@gmail.com",
  password: "123456",
  first_name: "Harry",
  last_name: "Sacht",
  weight: 78,
  height: 185,
  address: ADDRESS.sample,
  gender: "Male",
  belt: "Brown",
  years_of_experience: 6,
  description: "Keep an eye on my shoulders, not my hands.",
  training_style: "Both"
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669944330/Harry_Sacht_ml0qbg.png")
harry.photo.attach(io: file, filename: "harry.png", content_type: "image/png")
harry.save

letty = User.new(
  email: "letty.smith@gmail.com",
  password: "123456",
  first_name: "Letty",
  last_name: "Toretto",
  weight: 68,
  height: 152,
  address: ADDRESS.sample,
  gender: "Female",
  belt: "Blue",
  years_of_experience: 3,
  description: "I've taken down 10 people in a row, and you're next.",
  training_style: "Both"
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669944330/Letty_Toretto_vfcbya.png")
letty.photo.attach(io: file, filename: "letty.png", content_type: "image/png")
letty.save

p "Users created successfully."

p "Clearing out reviews"
Review.destroy_all

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

Review.create!(
  content: REVIEW_CONTENT.sample,
  user_id: justin.id,
  writer_id: ricky.id,
  rating: 2
)

Review.create!(
  content: REVIEW_CONTENT.sample,
  user_id: harry.id,
  writer_id: ricky.id,
  rating: 2
)

Review.create!(
  content: REVIEW_CONTENT.sample,
  user_id: letty.id,
  writer_id: ricky.id,
  rating: 2
)

p "Created reviews"

p "Clearing out events with attached guests too"
Event.destroy_all
Guest.destroy_all

event1 = Event.new(
  address: "5160 Gatineau",
  date: "Sun, 28 Dec 2022 20:00:00.000000000 EST -05:00",
  status: "Open",
  host: tsunami,
  description: "Bring your mat, I destroyed mine with the power of my suplex.",
  title: "Evening BJJ at touhami's."
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669942865/Le_wargon_bootcamp_z2nuyf.png")
event1.photo.attach(io: file, filename: "event1.png", content_type: "image/png")
event1.save

Guest.create!(
  event_id: Event.last.id,
  guest_id: [jimbo.id, jonathan.id, ricky.id].sample,
  status: Guest::STATUS.sample
)

event2 = Event.new(
  address: ricky.address,
  date: "Sun, 18 Dec 2022 16:00:00.000000000 EST -05:00",
  status: "Open",
  host: ricky,
  description: "Let's wrestle like it's the 70's baby!",
  title: "BJJ with a disco twist."
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1669943298/Disco_event_nigq0y.png")
event2.photo.attach(io: file, filename: "event2.png", content_type: "image/png")
event2.save

Guest.create!(
  event_id: Event.last.id,
  guest_id: [jimbo.id, tsunami.id, jonathan.id].sample,
  status: Guest::STATUS.sample
)

event3 = Event.new(
  address: jonathan.address,
  date: "Sun, 25 Dec 2022 10:00:00.000000000 EST -05:00",
  status: "Open",
  host: jonathan,
  description: "No time to lose, let's gooooo!",
  title: "High octane training."
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1670102565/event3_octagon_zmeias.png")
event3.photo.attach(io: file, filename: "event3.png", content_type: "image/png")
event3.save

Guest.create!(
  event_id: Event.last.id,
  guest_id: [tsunami.id, jimbo.id, ricky.id].sample,
  status: Guest::STATUS.sample
)

event4 = Event.new(
  address: jimbo.address,
  date: "Tue, 3 Jan 2023 18:00:00.000000000 EST -05:00",
  status: "Open",
  host: jimbo,
  description: "You'll never forget this, and you'll never mention it.",
  title: "Underground spar experience"
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1670102563/event5_fight_club_kcigya.png")
event4.photo.attach(io: file, filename: "event4.png", content_type: "image/png")
event4.save

Guest.create!(
  event_id: Event.last.id,
  guest_id: [claire.id, hugh.id, kaylee.id].sample,
  status: Guest::STATUS.sample
)

event5 = Event.new(
  address: hugh.address,
  date: "Sun, 1 Jan 2023 00:00:00.000000000 EST -05:00",
  status: "Open",
  host: hugh,
  description: "Let's ring in the new years the right way.",
  title: "New years!"
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1670102563/event4_dojo_aatbsm.png")
event5.photo.attach(io: file, filename: "event5.png", content_type: "image/png")
event5.save

Guest.create!(
  event_id: Event.last.id,
  guest_id: [claire.id, hugh.id, tiffany.id].sample,
  status: Guest::STATUS.sample
)

event6 = Event.new(
  address: kaylee.address,
  date: "Wed, 15 Feb 2023 18:00:00.000000000 EST -05:00",
  status: "Open",
  host: kaylee,
  description: "Doens't get more plain then this one",
  title: "Let's practice"
)

file = URI.open("https://res.cloudinary.com/dr82gggzf/image/upload/v1670102563/event6_studio_aopjok.png")
event6.photo.attach(io: file, filename: "event6.png", content_type: "image/png")
event6.save

Guest.create!(
  event_id: Event.last.id,
  guest_id: [claire.id, hugh.id, kaylee.id].sample,
  status: Guest::STATUS.sample
)

p "Created events with 1 semi-random guest each"

p "Destroying partner lists"
Partner.destroy_all

2.times do
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
  Partner.create!(
    requestee_id: tsunami.id,
    requester_id: User.all.ids.sample
  )
  Partner.create!(
    requester_id: tsunami.id,
    requestee_id: User.all.ids.sample
  )
end

p "Created partner lists for the four team members"

p "Creating real chatrooms and messages"

chat1 = Chatroom.create!(name: "private_#{ricky.id}_#{laura.id}_")
chat2 = Chatroom.create!(name: "private_#{ricky.id}_#{tsunami.id}_")
chat3 = Chatroom.create!(name: "private_#{ricky.id}_#{jonathan.id}_")
chat4 = Chatroom.create!(name: "private_#{laura.id}_#{tsunami.id}_")
chat5 = Chatroom.create!(name: "private_#{laura.id}_#{jonathan.id}_")
chat6 = Chatroom.create!(name: "private_#{tsunami.id}_#{jonathan.id}_")

Message.create!(
  content: "Hey Ricky, I was wondering if you'd wanna train?",
  chatroom_id: chat1.id,
  user_id: laura.id
)

Message.create!(
  content: "Ya, of course, I'm kinda relieve because I thought everyone here had joke names.",
  chatroom_id: chat1.id,
  user_id: ricky.id
)

Message.create!(
  content: "Wanna meet up at my place?",
  chatroom_id: chat1.id,
  user_id: ricky.id
)

Message.create!(
  content: "Hey Ricky, I really like your style, would you like to spar sometime?",
  chatroom_id: chat2.id,
  user_id: tsunami.id
)

Message.create!(
  content: "Hey Tsunami, you seem pretty cool, ya, I'd be open to it, what kind of training do you do?",
  chatroom_id: chat2.id,
  user_id: ricky.id
)

Message.create!(
  content: "I do mostly ground work but I actually also do kendo so I thought it would be cool if we could do both...",
  chatroom_id: chat2.id,
  user_id: tsunami.id
)

Message.create!(
  content: "But if we only do BJJ that would be fine too. It is the point of the app after all.",
  chatroom_id: chat2.id,
  user_id: tsunami.id
)

Message.create!(
  content: "Ya, Kendo kinda came out of nowhere but I'd still like to train with you, are you able to host?",
  chatroom_id: chat2.id,
  user_id: ricky.id
)

Message.create!(
  content: "Ya man, come meet me at my place whenever!",
  chatroom_id: chat2.id,
  user_id: tsunami.id
)

Message.create!(
  content: "WASSSUUUUUP",
  chatroom_id: chat3.id,
  user_id: jonathan.id
)

Message.create!(
  content: "WASSSUUUUUP",
  chatroom_id: chat3.id,
  user_id: ricky.id
)

Message.create!(
  content: "hahahha",
  chatroom_id: chat3.id,
  user_id: jonathan.id
)

Message.create!(
  content: "lmao",
  chatroom_id: chat3.id,
  user_id: ricky.id
)

Message.create!(
  content: "You're such a joker jon",
  chatroom_id: chat3.id,
  user_id: ricky.id
)

Message.create!(
  content: "Hey Laura, are you there?",
  chatroom_id: chat4.id,
  user_id: tsunami.id
)

Message.create!(
  content: "Hey, glad you decided to join up!",
  chatroom_id: chat5.id,
  user_id: jonathan.id
)

Message.create!(
  content: "Of course, thanks for telling me about Home-Jitsu :)",
  chatroom_id: chat5.id,
  user_id: laura.id
)

Message.create!(
  content: "Hey, just a suggestion you should check out this guy called Jim, I think he'd be a good match.",
  chatroom_id: chat5.id,
  user_id: jonathan.id
)

Message.create!(
  content: "Hey Touhami! I was wondering if you're around in Mtl to train???",
  chatroom_id: chat6.id,
  user_id: jonathan.id
)

Message.create!(
  content: "Ya man, I live here, I'd love to train!",
  chatroom_id: chat6.id,
  user_id: tsunami.id
)

Message.create!(
  content: "Cool, also before we figure that out I was wondering how to pronounce your name?",
  chatroom_id: chat6.id,
  user_id: jonathan.id
)

Message.create!(
  content: "Just call me tsunami, it's what everyone that has trouble with that calls me haha.",
  chatroom_id: chat6.id,
  user_id: tsunami.id
)

Message.create!(
  content: "Alright, sure thing Tsunami, would you be down to come over next tues to train?",
  chatroom_id: chat6.id,
  user_id: jonathan.id
)

Message.create!(
  content: "Sounds like a plan.",
  chatroom_id: chat6.id,
  user_id: tsunami.id
)

p "Created real chatrooms and messages"
