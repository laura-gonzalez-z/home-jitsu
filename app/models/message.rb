class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  after_create_commit do
    notify_recipient
  end

  private

  def joined_users
    room = self.chatroom.name
    room.scan(/\d+/).map(&:to_i)
  end

  def notify_recipient
    users_in_room = self.joined_users
    users_in_room.each do |user|
      next if user.eql?(self.user_id)

      notification = MessageNotification.with(message: self, chatroom: message.chatroom)
      notification.deliver_later(user)
    end
  end
end
