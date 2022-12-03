class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  validates :content, length: { minimum: 1 }
  def joined_users
    room = self.chatroom.name
    ids = room.scan(/\d+/).map(&:to_i)
    users = ids.map { |id| User.find(id) }
    return users
  end
end
