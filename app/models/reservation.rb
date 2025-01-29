class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :rev_checkin, :rev_checkout, presence: true
  validates :rev_headcount, presence: true, numericality: {greater_than_or_equal_to: 1}
  validate :endAfterStart
  validate :date_before_start
  
  def stay_duration
   stay_days = (rev_checkout - rev_checkin).to_i
  end

  def total_price
   total = stay_duration * room.room_fee * rev_headcount
  end

  private

  def date_before_start
    return if self.rev_checkin.blank?
    errors.add(:rev_checkin, "は今日以降のものを選択してください") if self.rev_checkin < Date.today
  end

  def endAfterStart
    return if rev_checkin.blank? || rev_checkout.blank?
    if rev_checkout <= rev_checkin
      errors.add(:rev_checkout, "はチェックイン日より後の日付としてください")
    end
  end
end
