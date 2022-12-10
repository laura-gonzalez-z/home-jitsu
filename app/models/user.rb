class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  BELTS = ["White", "Blue", "Purple", "Brown", "Black", "None"].freeze
  GENDERS = ["Male", "Female", "Other"].freeze
  TRAINING_STYLES = ["Gi", "No-gi", "Both"].freeze

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
  validates :training_style, presence: true
  validates :training_style, inclusion: { in: TRAINING_STYLES }

  has_many :written_reviews, class_name: 'Review', foreign_key: 'writer_id'
  has_many :reviews, class_name: 'Review', foreign_key: 'user_id'
  has_many :requested_partners, class_name: 'Partner', foreign_key: 'requester_id'
  has_many :partners, class_name: 'Partner', foreign_key: 'requestee_id'
  has_many :hosted_events, class_name: 'Event', foreign_key: 'host_id'
  has_many :events, class_name: 'Guest', foreign_key: 'guest_id'
  has_one_attached :photo

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def distance_to(geolocation)
    Geocoder::Calculations.distance_between(geolocation, [latitude, longitude])
  end

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

  def unread_notifications
    notifications.unread.select { |notification| notification.params[:type] != 'message' }
  end

  def unread_messages
    notifications.unread.select { |notification| notification.params[:type] == 'message' }
  end
end
