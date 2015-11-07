class Submission < ActiveRecord::Base
  belongs_to :chart

  validate :check_data

  before_save :set_score

  private

  def check_data
    return if ChecksSubmissionData.ok?(chart, data)
    errors.add(:data, "malformed")
  end

  def set_score
    self.score = ScoresSubmissions.score(data)
  end
end
