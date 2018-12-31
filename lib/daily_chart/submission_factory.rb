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
      validate

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

    private

    def validate
      raise ArgumentError, "Overlap detected" if overlap?
      raise ArgumentError, "Item not found!" if unfound_items?
      raise ArgumentError, "Missing items" if missing_items?
    end

    def overlap?
      (checked & unchecked).any?
    end

    def unfound_items?
      checked_items.size != checked.size ||
        unchecked_items.size != unchecked.size
    end

    def missing_items?
      checked.size + unchecked.size != chart.items.count
    end

    def checked_items
      @checked_items ||= chart.items.where(name: checked)
    end

    def unchecked_items
      @unchecked_items ||= chart.items.where(name: unchecked)
    end

    def submission
      @submission ||= chart.submissions.new
    end
  end
end
