require "rails_helper"
require "daily_chart"

RSpec.describe DailyChart do
  describe ".generate_stats" do
    example "integration" do
      chart = create(
        :chart,
        items_attributes: [{name: "Floss"}, {name: "Exercise"}]
      )

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

      expect(stats).to have_attributes(daily_percentages: [0.0, 0.0, 0.0, 0.0, 50.0, 0.0, 100.0],
                                       weekly_averages: [21.43],
                                       weeks_all_time: [1])
    end
  end
end
