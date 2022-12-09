class Chatroom < ApplicationRecord
  has_many :messages
  has_noticed_notifications model_name: 'Notification'

  def other_user(current_user)
    room = self.name
    ids = room.scan(/\d+/).map(&:to_i)
    other_id = ids.select { |id| id != current_user.id }
    user = User.find(other_id[0])
    return user
  end
end
