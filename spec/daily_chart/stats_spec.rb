require "rails_helper"

RSpec.describe DailyChart::Stats do
  describe "#daily" do
    it "fills in the blanks for no submission days" do
      Timecop.freeze("2018-01-01") do
        chart = Chart.create!(items: [Item.create(name: "Exercise")])
        chart.submissions.create!(data: { "Exercise" => "1" }, date: 7.days.ago.to_date)

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

    xit "provides some data when no submissions have been made" do
      Timecop.freeze("2018-01-01") do
        chart = Chart.create!(items: [Item.create(name: "Exercise")])

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
end
