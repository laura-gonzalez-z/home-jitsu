require 'date'

class Event < ApplicationRecord
  STATUS = ["Open", "Closed"].freeze
  belongs_to :host, class_name: 'User'
  has_many :guests
  has_one_attached :photo

  validates :date, presence: true
  validates :status, inclusion: { in: STATUS }
  validates :title, presence: true
  validates :description, presence: true
end
