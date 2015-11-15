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

  def date
    Date.parse(read_attribute(:date))
  end

  def date=(d)
    write_attribute(:date, d.to_s)
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
end
