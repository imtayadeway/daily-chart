module DailyChart
  class SubmissionFactory
    # Builds a submission without persisting it to the database.
    #
    # @param chart [Chart] the chart
    # @param data [Array<String>] a hash of item names mapped to a
    #   value indicating whether it is checked, e.g.
    #   <tt>{"Floss" => true, "Exercise" => false}</tt>
    # @param date [Date] the date of the submission. Defaults to
    #   current
    # @return submission [Submission]
    def self.build(chart:, data: {}, date: nil)
      new(chart: chart, data: data, date: date).build
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
    def self.create(chart:, data: {}, date: nil)
      submission = build(chart: chart, data: data, date: date)
      submission.save!
      submission
    end

    attr_reader :chart, :data, :date

    def initialize(chart:, data:, date:)
      @chart = chart
      @data = data
      @date = date
    end

    def build
      validate
      build_submission
      submission
    end

    private

    def validate
      raise ArgumentError, "Item not found!" if unfound_items?
      raise ArgumentError, "Missing items" if missing_items?
    end

    def unfound_items?
      item_names.size != items.size
    end

    def missing_items?
      items.size != chart.items.count
    end

    def build_submission
      data.each do |name, checked|
        item = fetch_item(name)
        build_submission_detail(item, checked)
      end
    end

    def fetch_item(name)
      items_by_name.fetch(name)
    end

    def items_by_name
      @items_by_name ||= items.each_with_object({}) do |i, hsh|
        hsh[i.name] = i
      end
    end

    def items
      @items ||= chart.items.where(name: item_names)
    end

    def item_names
      data.keys
    end

    def submission
      @submission ||= chart.submissions.new({date: date}.compact)
    end

    def build_submission_detail(item, checked)
      submission.submission_details.new(
        chart: chart,
        item: item,
        checked: checked
      )
    end
  end
end
