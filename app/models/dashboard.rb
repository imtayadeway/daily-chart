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
      week.map(&:percent).inject(:+) / week.size
    end
  end

  def weeks_all_time
    1.upto((scorables.size / 7) + 1).to_a
  end

  def best_this_week
    chart.items.max_by { |item| weekly_score_for(item) }.name
  end

  def worst_this_week
    chart.items.min_by { |item| weekly_score_for(item) }.name
  end

  private

  def last(x_days)
    scorables.last(x_days)
  end

  def weekly_score_for(item)
    last(7).map { |scorable| scorable.data[item.name].to_i }.reduce(:+)
  end
end
