class Room < ApplicationRecord
  validates :room_name, presence: true
  validates :room_introduction, presence: true
  validates :room_fee, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :room_address, presence: true

  def self.search(search)
    return Room.all unless search
    Room.where('room_name LIKE(?)', "%#{search}%")
  end

  has_many :reservations
  belongs_to :user
end
