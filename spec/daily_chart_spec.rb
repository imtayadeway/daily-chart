require "rails_helper"
require "daily_chart"

RSpec.describe DailyChart do
  describe ".generate_stats" do
    example "integration" do
      chart = create(
        :chart,
        items_attributes: [{name: "Floss"}, {name: "Exercise"}]
      )

      Timecop.freeze("2018-01-01") do
        DailyChart.create_submission(
          chart: chart,
          data: { "Floss" => false, "Exercise" => false },
          date: 7.days.ago
        )

        DailyChart.create_submission(
          chart: chart,
          data: { "Floss" => false, "Exercise" => false },
          date: 6.days.ago
        )

        DailyChart.create_submission(
          chart: chart,
          data: { "Floss" => false, "Exercise" => false },
          date: 5.days.ago
        )

        DailyChart.create_submission(
          chart: chart,
          data: { "Floss" => false, "Exercise" => false },
          date: 4.days.ago
        )

        DailyChart.create_submission(
          chart: chart,
          data: { "Floss" => true, "Exercise" => false },
          date: 3.days.ago
        )

        DailyChart.create_submission(
          chart: chart,
          data: { "Floss" => false, "Exercise" => false },
          date: 2.days.ago
        )

        DailyChart.create_submission(
          chart: chart,
          data: { "Floss" => true, "Exercise" => true },
          date: 1.day.ago
        )

        stats = DailyChart.generate_stats(chart: chart)

        expected = {
          daily: [
            ["Mon", 0.0],
            ["Tue", 0.0],
            ["Wed", 0.0],
            ["Thu", 0.0],
            ["Fri", 50.0],
            ["Sat", 0.0],
            ["Sun", 100.0],
          ],
          weekly: [21.43]
        }
        expect(stats).to have_attributes(expected)
      end
    end
  end
end
