class Submission < ActiveRecord::Base
  include DateFormatters
  belongs_to :chart

  validates :date, uniqueness: true, presence: true
  validate :data_validity

  before_validation :set_date
  before_save :set_score

  def self.pending?
    find_by(date: Time.zone.today.to_s).nil?
  end

  def date
    Date.parse(read_attribute(:date))
  end

  def date=(d)
    write_attribute(:date, d.to_s)
  end

  def percent
    (score.to_f / max_score * 100.0).round(2)
  end

  def score_for(item_name)
    data[item_name].to_i
  end

  private

  def data_validity
    return if ChecksSubmissionData.ok?(chart, data)
    errors.add(:data, "malformed")
  end

  def set_score
    self.score = ScoresSubmissions.score(data)
  end

  def set_date
    return if read_attribute(:date)
    self.date = Time.zone.today
  end

  def max_score
    data.size
  end
end
