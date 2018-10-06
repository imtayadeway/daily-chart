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
            { "Monday" => { "Floss" => false, "Exercise" => false } },
            { "Tuesday" => { "Floss" => false, "Exercise" => false } },
            { "Wednesday" => { "Floss" => false, "Exercise" => false } },
            { "Thursday" => { "Floss" => false, "Exercise" => false } },
            { "Friday" => { "Floss" => true, "Exercise" => false } },
            { "Saturday" => { "Floss" => false, "Exercise" => false } },
            { "Sunday" => { "Floss" => true, "Exercise" => true } }
          ],
          weekly: [21.43]
        }
        expect(stats).to have_attributes(expected)
      end
    end
  end
end
