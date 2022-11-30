class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  BELTS = ["White", "Blue", "Purple", "Brown", "Black", "None"].freeze
  GENDERS = ["Male", "Female", "Other"].freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :weight, presence: true
  validates :weight, length: { in: 2..4 }
  validates :weight, comparison: { greater_than: 0 }
  validates :height, presence: true
  validates :height, length: { in: 2..4 }
  validates :height, comparison: { greater_than: 0 }
  validates :belt, inclusion: { in: BELTS }
  validates :years_of_experience, comparison: { greater_than_or_equal_to: 0 }
  validates :address, presence: true
  validates :gender, presence: true
  validates :gender, inclusion: { in: GENDERS }

  has_many :written_reviews, class_name: 'Review', foreign_key: 'writer_id'
  has_many :reviews, class_name: 'Review', foreign_key: 'user_id'
  has_many :requested_partners, class_name: 'Partner', foreign_key: 'requester_id'
  has_many :partners, class_name: 'Partner', foreign_key: 'requestee_id'
  has_many :hosted_events, class_name: 'Event', foreign_key: 'host_id'
  has_many :events, class_name: 'Guest', foreign_key: 'guest_id'
  has_one_attached :photo

  def partnerships
    requested_partners + partners
  end

  def friends
    list = partnerships.map do |p|
      other_user = p.users.find { |u| u.id != id }
      other_user
    end
    list.compact.uniq
  end
  has_many :messages
  has_many :notifications, as: :recipient, dependent: :destroy
end
