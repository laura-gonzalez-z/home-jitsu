class Review < ApplicationRecord
  has_many :users

  validates :content, presence: true
  validates :rating, presence: true
  validates :rating, inclusion: { in: [1, 2, 3, 4, 5] }
  validates :user_id, presence: true
  validates :writer_id, presence: true
end
