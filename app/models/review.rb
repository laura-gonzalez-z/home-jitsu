class Review < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :writer, class_name: 'User'

  validates :content, presence: true
  validates :rating, presence: true
  validates :rating, inclusion: { in: [1, 2, 3, 4, 5] }
  validates :user_id, presence: true
  validates :writer_id, presence: true
end
