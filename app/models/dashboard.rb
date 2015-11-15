class Dashboard
  attr_reader :chart

  def initialize(chart)
    @chart = chart
  end

  def submission_pending?
    chart.submission_pending?
  end

  def scores
    chart.scores
  end
end
