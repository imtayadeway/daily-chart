module DailyChart
  class Stats
    def initialize(chart)
      @chart = chart
      @scorables = Scorables.for(ScorableDays.for(chart), chart.submissions.to_a)
    end

    def daily
      Submission.find_by_sql([<<~SQL, @chart.id]).map { |s| [s.weekday, s.percent] }
        WITH last_seven_days(date) AS (
          VALUES #{daily_date_range.map { |d| "('#{d}'::varchar)"}.join(",")}
        )
        SELECT COALESCE(score, 0) AS score, COALESCE(data, '{}'::json) AS data, lsd.date
        FROM submissions AS s
        RIGHT OUTER JOIN last_seven_days lsd ON s.date = lsd.date
        AND chart_id = ?
        ORDER by lsd.date
      SQL
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

    private

    def daily_date_range
      Date.yesterday.downto(Date.today - 7)
    end
  end
end
