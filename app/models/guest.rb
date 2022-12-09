class Guest < ApplicationRecord
  belongs_to :event
  belongs_to :guest, class_name: 'User'
  STATUS = ["Pending", "Accept", "Reject", "Invited"]

  validates :event_id, presence: true
  validates :guest_id, presence: true
  validates :status, inclusion: { in: STATUS }
end
