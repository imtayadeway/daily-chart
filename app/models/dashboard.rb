class Dashboard
  attr_reader :chart
  delegate :submission_pending?, to: :chart

  def initialize(chart)
    @chart = chart
  end

  def best_this_week
    stats.best_item
  end

  def worst_this_week
    stats.worst_item
  end

  def last_seven_days
    last(7).map(&:weekday)
  end

  def daily_percentages
    last(7).map(&:percent)
  end

  def scorables
    @scorables ||= Scorables.for(ScorableDays.for(chart), chart.submissions.to_a)
  end

  def weekly_averages
    CalculatesAverages.for(scorables)
  end

  def weeks_all_time
    EnumeratesWeeks.for(scorables.size)
  end

  private

  def stats
    @stats ||= Stats.new(last(7), chart.items)
  end

  def last(x_days)
    scorables.last(x_days)
  end
end
