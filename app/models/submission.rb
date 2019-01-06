class Submission < ActiveRecord::Base
  include DateFormatters
  belongs_to :chart
  has_many :submission_details

  validates :date, uniqueness: true, presence: true

  before_validation :set_date
  before_save :set_score

  def self.pending?
    find_by(date: Time.zone.today).nil?
  end

  def percent
    (score.to_f / max_score * 100.0).round(2)
  end

  private

  def set_score
    self.score = submission_details.count(&:checked?)
  end

  def set_date
    self.date ||= Time.zone.today
  end

  def max_score
    submission_details.count
  end
end
