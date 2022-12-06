class Chatroom < ApplicationRecord
  has_many :messages
  has_noticed_notifications model_name: 'Notification'
end
