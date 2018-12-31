module DailyChart
  class SubmissionFactory
    #
    # @param chart [Chart] the chart
    # @param checked [Array<String>] the list checked items, e.g.
    #   <tt>["Floss", "Exercise"]</tt>
    # @param unchecked [Array<String>] the list of unchecked items
    # @return submission [Submission]
    def self.build(chart:, checked: [], unchecked: [])
      new(chart: chart, checked: checked, unchecked: unchecked).build
    end

    attr_reader :chart, :checked, :unchecked

    def initialize(chart:, checked:, unchecked:)
      @chart = chart
      @checked = Set.new(checked)
      @unchecked = Set.new(unchecked)
    end

    def build
      raise ArgumentError, "Overlap detected" if (checked & unchecked).any?
      checked_items = chart.items.where(name: checked)
      unchecked_items = chart.items.where(name: unchecked)
      raise ArgumentError, "Item not found!" unless checked_items.size == checked.size
      raise ArgumentError, "Item not found!" unless unchecked_items.size == unchecked.size
      raise ArgumentError, "Missing items" unless checked.size + unchecked.size == chart.items.count

      submission = chart.submissions.new

      checked_items.each do |item|
        submission.submission_details.new(
          chart: chart,
          item: item,
          checked: true
        )
      end

      unchecked_items.each do |item|
        submission.submission_details.new(
          chart: chart,
          item: item,
          checked: false
        )
      end

      submission
    end
  end
end
