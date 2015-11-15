# == Schema Information
#
# Table name: charts
#
#  id      :integer          not null, primary key
#  user_id :integer
#

class Chart < ActiveRecord::Base
  belongs_to :user
  has_many :items
  has_many :submissions, -> { order(:date) }

  accepts_nested_attributes_for :items

  def item_names
    items.map(&:name)
  end

  def scores
    submission_days.map do |date|
      submission = submissions.detect { |sub| sub.date == date }
      if submission
        Score.new(date, submission.score)
      else
        Score.new(date, 0)
      end
    end
  end

  def submission_pending?
    submissions.pending?
  end

  private

  def submission_days
    return [] unless first_submission_date
    first_submission_date..last_submission_date
  end

  def first_submission_date
    return nil if submissions.empty?
    submissions.first.date
  end

  def last_submission_date
    return nil if submissions.empty?
    if submissions.last.date.today?
      submissions.last.date
    else
      (Time.zone.today - 1)
    end
  end
end
