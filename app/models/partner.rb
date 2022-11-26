class Partner < ApplicationRecord
  has_many :users
  STATUS = ["pending", "accepted", "rejected"]

  validates :requester_id, presence: true
  validates :requestee_id, presence: true
  validates :status, inclusion: { in: STATUS }

  def exists?
    Partner.find(requester_id: current_user.id, requestee_id: @user.id) ||
      Partner.find(requestee_id: current_user.id, requester_id: @user.id)
  end

end
