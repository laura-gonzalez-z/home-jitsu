class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  validates :content, presence: true

  def sender?(a_user)
    user.id == a_user.id
  end

  def joined_users
    room = self.chatroom.name
    ids = room.scan(/\d+/).map(&:to_i)
    users = ids.map { |id| User.find(id) }
    return users
  end
end
