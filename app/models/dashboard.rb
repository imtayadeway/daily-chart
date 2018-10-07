class Dashboard
  attr_reader :chart, :stats
  delegate :submission_pending?, to: :chart

  def initialize(chart)
    @chart = chart
    @stats = DailyChart.generate_stats(chart: chart)
  end

  def last_seven_days
    stats.daily.map(&:first)
  end

  def daily_percentages
    stats.daily.map(&:second)
  end

  def weekly_percentages
    stats.weekly
  end

  def weeks_all_time
    EnumeratesWeeks.for(scorables.size)
  end

  private

  def scorables
    @scorables ||= Scorables.for(ScorableDays.for(chart), chart.submissions.to_a)
  end
end
