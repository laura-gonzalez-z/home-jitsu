require 'date'

class Event < ApplicationRecord
  STATUS = ["open", "closed"].freeze
  belongs_to :host, class_name: 'User'
  has_many :guests

  validates :date, presence: true
  validates :date, comparison: { greater_than: Date.today }
  validates :status, inclusion: { in: STATUS }
  validates :host_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :photo, presence: true
end
