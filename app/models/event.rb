require 'date'

class Event < ApplicationRecord
  STATUS = ["Open", "Closed"].freeze
  belongs_to :host, class_name: 'User'
  has_many :guests

  validates :date, presence: true
  validates :status, inclusion: { in: STATUS }
  validates :title, presence: true
  validates :description, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
