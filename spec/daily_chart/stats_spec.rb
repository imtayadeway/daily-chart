require "rails_helper"

RSpec.describe DailyChart::Stats do
  describe "#daily" do
    it "fills in the blanks for no submission days" do
      Timecop.freeze("2018-01-01") do
        chart = create(:chart, items: [Item.create(name: "Exercise")])
        DailyChart::SubmissionFactory.create(
          chart: chart,
          data: { "Exercise" => true },
          date: 7.days.ago
        )

        actual = DailyChart::Stats.new(chart).daily
        expected = [
          ["Mon", 100.0],
          ["Tue", 0.0],
          ["Wed", 0.0],
          ["Thu", 0.0],
          ["Fri", 0.0],
          ["Sat", 0.0],
          ["Sun", 0.0],
        ]
        expect(actual).to eq(expected)
      end
    end

    it "provides some data when no submissions have been made" do
      Timecop.freeze("2018-01-01") do
        chart = create(:chart, items: [Item.create(name: "Exercise")])

        actual = DailyChart::Stats.new(chart).daily
        expected = [
          ["Mon", 0.0],
          ["Tue", 0.0],
          ["Wed", 0.0],
          ["Thu", 0.0],
          ["Fri", 0.0],
          ["Sat", 0.0],
          ["Sun", 0.0],
        ]
        expect(actual).to eq(expected)
      end
    end
  end

  describe "#weekly" do
    it "aggregates scores by week" do
      chart = create(:chart, items: [Item.create(name: "Exercise"), Item.create(name: "Floss")])
      DailyChart::SubmissionFactory.create(chart: chart, data: { "Exercise" => true, "Floss" => false }, date: Date.today)
      DailyChart::SubmissionFactory.create(chart: chart, data: { "Exercise" => true, "Floss" => false }, date: Date.today - 7)

      actual = DailyChart::Stats.new(chart).weekly
      expected = [["Exercise", [14.29, 14.29]],
                  ["Floss", [0.0, 0.0]]]
      expect(actual).to eq(expected)
    end
  end
end
