class Event < ApplicationRecord
  belongs_to :user
  has_many :reservations
  has_many :attendees, through: :reservations, source: :user
  has_one_attached :image

  has_many :reservations
has_many :attendees, through: :reservations, source: :user
  # app/models/event.rb
before_save :set_default_price

def set_default_price
  self.price ||= 0
end

end
