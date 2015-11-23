# == Schema Information
#
# Table name: submissions
#
#  id       :integer          not null, primary key
#  score    :integer
#  data     :json
#  chart_id :integer
#  date     :string
#

class Submission < ActiveRecord::Base
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
    score.to_f / max_score * 100.0
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
    self.date = Time.zone.today
  end

  def max_score
    data.size
  end
end
