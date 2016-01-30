class Dashboard
  attr_reader :chart
  delegate :weekly_averages, :weeks_all_time, :best_this_week, :worst_this_week,
           :last_seven_days, :daily_percentages, :submission_pending?,
           :scorables, to: :chart

  def initialize(chart)
    @chart = chart
  end
end
