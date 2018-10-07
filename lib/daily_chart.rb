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

  class Stats
    def initialize(chart)
      @scorables = Scorables.for(ScorableDays.for(chart), chart.submissions.to_a)
    end

    def daily
      @scorables.last(7).map { |s| [s.weekday, s.percent] }
    end

    def weekly
      @scorables.each_slice(7).each_with_object({}) do |week, result|
        result.each_value do |v|
          v << 0
        end
        week.each do |submission|
          submission.data.each do |k,v|
            result[k] ||= [0]
            result[k][-1] += 1 if v == "1"
          end
        end
        result.values.each { |v| v[-1] = (v[-1] / 0.07).round(2) }
      end.sort.to_a
    end
  end

  def self.generate_stats(chart:)
    Stats.new(chart)
  end
end
