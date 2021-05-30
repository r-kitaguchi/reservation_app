class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :start_date, :end_date, :number, presence: true
  validates :start_date, :end_date, uniqueness:{scope: :room}
  validates :number, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 10}, allow_blank: true
  validate :date_before_start
  validate :date_before_end

  def date_before_start
    if start_date.blank?
      return
    elsif start_date < Date.today
      errors.add(:start_date, ":今日以降の日付を入力してください")
    end
  end

  def date_before_end
    if end_date.blank?
      return
    elsif end_date < start_date
      errors.add(:end_date, ":チェックインの日以降の日付を入力してください")
    end
  end
end
