class Dashboard
  attr_reader :chart
  delegate :submission_pending?, :scorables, to: :chart

  def initialize(chart)
    @chart = chart
  end

  def last_seven_days
    last(7).map(&:weekday)
  end

  def weekly_percentages
    last(7).map(&:percent)
  end

  def last_thirty_days
    last(30).map(&:day)
  end

  def monthly_percentages
    last(30).map(&:percent)
  end

  private

  def last(x_days)
    scorables.last(x_days)
  end
end
