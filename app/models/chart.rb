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
    submitted_scores = submissions.to_a
    ScorableDays.for(self).map do |date|
      value = if submitted_scores.first.date == date
                submitted_scores.shift.score
              else
                0
              end
      Score.new(date, value)
    end
  end

  def submission_pending?
    submissions.pending?
  end
end
