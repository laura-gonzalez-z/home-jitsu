class Partner < ApplicationRecord
  has_many :users
  STATUS = ["pending", "accepted", "rejected"]

  validates :requester_id, presence: true
  validates :requestee_id, presence: true
  validates :status, inclusion: { in: STATUS }
end
