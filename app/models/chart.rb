class Chart < ActiveRecord::Base
  belongs_to :user
  has_many :items
  has_many :submissions

  accepts_nested_attributes_for :items

  def item_names
    items.map(&:name)
  end

  def scores
    submission_days.map do |date|
      submissions.detect { |submission| submission.created_at == date } || NoSubmission.new
    end.map(&:score)
  end

  private

  def submission_days
    first_submission.created_at.to_date..(Date.today - 1)
  end

  def first_submission
    submissions.min_by(&:created_at)
  end
end
