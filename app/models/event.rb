require 'date'

class Event < ApplicationRecord
  STATUS = ["Open", "Closed"].freeze
  belongs_to :host, class_name: 'User'
  has_many :guests

  validates :date, presence: true
  validates :status, inclusion: { in: STATUS }
  validates :host, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :photo, presence: true
end
