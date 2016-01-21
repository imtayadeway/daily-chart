class NoSubmission
  include DateFormatters
  attr_reader :date

  def initialize(date)
    @date = date
  end

  def score
    0
  end

  def percent
    0.0
  end

  def data
    {}
  end
end
