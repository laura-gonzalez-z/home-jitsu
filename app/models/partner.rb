class Partner < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User'

  STATUS = ["pending", "accepted", "rejected"]

  validates :requester_id, presence: true
  validates :requestee_id, presence: true
  validates :status, inclusion: { in: STATUS }

  def users
    [requester, requestee]
  end

  def exists?
    Partner.find(requester_id: current_user.id, requestee_id: @user.id) ||
      Partner.find(requestee_id: current_user.id, requester_id: @user.id)
  end
end
