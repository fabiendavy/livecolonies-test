class Stay < ApplicationRecord
  DAYS_IN_MONTHS = {
    January: 31,
    February: 28,
    March: 31,
    April: 30,
    May: 31,
    June: 30,
    July: 31,
    August: 31,
    September: 30,
    October: 31,
    November: 30,
    December: 31
  }
  
  belongs_to :tenant
  belongs_to :studio
  
  validates :start_date, :end_date, presence: true
  validate :start_before_end
  validate :valid_dates

  private

  def start_before_end
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, "must be after the start date") if end_date < start_date
  end

  def valid_dates
    stays = Stay.where(studio: studio)
    date_ranges = stays.map { |stay| stay.start_date..stay.end_date }

    date_ranges.each do |date_range|
      errors.add(:start_date, "not availabe") if date_range.include?(start_date)
      errors.add(:end_date, "not availabe") if date_range.include?(end_date)      
    end
  end
end
