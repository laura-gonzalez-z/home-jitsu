class Guest < ApplicationRecord
  belongs_to :event
  belongs_to :guest, class_name: 'User'
  STATUS = ["pending", "accepted", "rejected"]

  validates :event_id, presence: true
  validates :guest_id, presence: true
  validates :status, inclusion: { in: STATUS }

end
