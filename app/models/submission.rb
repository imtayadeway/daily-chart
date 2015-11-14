# == Schema Information
#
# Table name: submissions
#
#  id         :integer          not null, primary key
#  score      :integer
#  data       :json
#  chart_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Submission < ActiveRecord::Base
  belongs_to :chart

  validate :date_validity, on: :create
  validate :data_validity

  before_save :set_score

  def date
    created_at.try(:to_date)
  end

  private

  def date_validity
    return unless chart.submissions.where("DATE(created_at) = ?", Time.zone.now.to_date).any?
    errors.add(:created_at, "already submitted today")
  end

  def data_validity
    return if ChecksSubmissionData.ok?(chart, data)
    errors.add(:data, "malformed")
  end

  def set_score
    self.score = ScoresSubmissions.score(data)
  end
end
