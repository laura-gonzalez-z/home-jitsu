class Review < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :writer, class_name: 'User'
end
