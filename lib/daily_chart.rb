module DailyChart
  # Builds a submission without persisting it to the database.
  #
  # @param chart [Chart] the chart
  # @param data [Array<String>] a hash of item names mapped to a
  #   value indicating whether it is checked, e.g.
  #   <tt>{"Floss" => true, "Exercise" => false}</tt>
  # @param date [Date] the date of the submission. Defaults to
  #   current
  # @return submission [Submission]
  def self.build_submission(chart:, data: {}, date: nil)
    SubmissionFactory.new(chart: chart, data: data, date: date).build
  end

  # Creates a submission, persisting it to the database. Raises if
  # it fails validation.
  #
  # @param chart [Chart] the chart
  # @param data [Array<String>] a hash of item names mapped to a
  #   value indicating whether it is checked, e.g.
  #   <tt>{"Floss" => true, "Exercise" => false}</tt>
  # @param date [Date] the date of the submission. Defaults to
  #   current
  # @return submission [Submission]
  def self.create_submission(chart:, data: {}, date: nil)
    SubmissionFactory.new(
      chart: chart,
      data: data,
      date: date
    ).build.tap(&:save!)
  end

  def self.generate_stats(chart:)
    Stats.new(chart)
  end
end
