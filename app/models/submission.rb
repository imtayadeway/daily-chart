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
    return 0.0 if max_score.zero?
    (score.to_f / max_score * 100.0).round(2)
  end

  def score_for(item_name)
    data[item_name].to_i
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
