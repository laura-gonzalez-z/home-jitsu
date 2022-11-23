class Partner < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User'
  STATUS = ["pending", "accepted", "rejected"]

  validates :requester_id, presence: true
  validates :requestee_id, presence: true
  validates :status, inclusion: { in: STATUS }
end
