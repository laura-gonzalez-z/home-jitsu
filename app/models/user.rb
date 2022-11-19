class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  BELTS = ["White", "Blue", "Purple", "Brown", "Black"].freeze
  GENDERS = ["Male", "Female", "Other"].freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :weight, presence: true
  validates :weight, length: { in: 2..4 }
  validates :height, presence: true
  validates :height, length: { in: 2..4 }
  validates :belt, inclusion: { in: BELTS }
  validates :years_of_experience, length: { in: 1..3 }
  validates :address, presence: true
  validates :gender, presence: true
  validates :gender, inclusion: { in: GENDERS }
end
