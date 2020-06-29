class Stay < ApplicationRecord
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
