class Dashboard
  attr_reader :chart
  delegate :submission_pending?, :scorables, to: :chart

  def initialize(chart)
    @chart = chart
  end

  def last_seven_days
    last(7).map(&:weekday)
  end

  def daily_percentages
    last(7).map(&:percent)
  end

  def weekly_averages
    scorables.each_slice(7).map do |week|
      week.map(&:percent).inject(:+) / 7
    end
  end

  def weeks_all_time
    1.upto((scorables.size / 7) + 1).to_a
  end

  private

  def last(x_days)
    scorables.last(x_days)
  end
end
