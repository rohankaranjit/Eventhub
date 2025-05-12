class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { regular_user: 0, organizer: 1, admin: 2 }

  has_many :events
  
  has_many :reservations
has_many :registered_events, through: :reservations, source: :event

end
