class Dashboard
  attr_reader :chart
  delegate(
    :best_this_week,
    :daily_percentages,
    :last_seven_days,
    :scorables,
    :submission_pending?,
    :weekly_averages,
    :weeks_all_time,
    :worst_this_week,
    to: :chart
  )

  def initialize(chart)
    @chart = chart
  end
end
