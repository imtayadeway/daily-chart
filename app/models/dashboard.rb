class Dashboard
  attr_reader :chart, :stats
  delegate :submission_pending?, to: :chart

  def initialize(chart)
    @chart = chart
    @stats = DailyChart.generate_stats(chart: chart)
  end

  def last_seven_days
    last(7).map(&:weekday)
  end

  def daily_percentages
    last(7).map(&:percent)
  end

  def weekly_averages
    stats.weekly
  end

  def weeks_all_time
    EnumeratesWeeks.for(scorables.size)
  end

  private

  def scorables
    @scorables ||= Scorables.for(ScorableDays.for(chart), chart.submissions.to_a)
  end

  def last(x_days)
    scorables.last(x_days)
  end
end
