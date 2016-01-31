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

  def submission_pending?
    submissions.pending?
  end

  def scorables
    @scorables ||= Scorables.for(ScorableDays.for(self), submissions.to_a)
  end

  def scores
    scorables.map(&:score)
  end

  def percentages
    scorables.map(&:percent)
  end

  def last_seven_days
    last(7).map(&:weekday)
  end

  def daily_percentages
    last(7).map(&:percent)
  end

  def weekly_averages
    CalculatesAverages.for(scorables)
  end

  def weeks_all_time
    EnumeratesWeeks.for(scorables.size)
  end

  def best_this_week
    stats.best_item
  end

  def worst_this_week
    stats.worst_item
  end

  private

  def last(x_days)
    scorables.last(x_days)
  end

  def stats
    @stats ||= Stats.new(last(7), items)
  end
end
