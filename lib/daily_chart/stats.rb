module DailyChart
  class Stats
    def initialize(chart)
      @chart = chart
      @scorables = Scorables.for(ScorableDays.for(chart), chart.submissions.to_a)
    end

    def daily
      Submission.find_by_sql([<<~SQL, chart.id]).map { |s| [s.weekday, s.percent] }
        WITH last_seven_days(date) AS (
          VALUES #{daily_date_range.map { |d| "('#{d}'::date)"}.join(",")}
        )
        SELECT id,
               COALESCE(score, 0) AS score,
               chart_id,
               lsd.date
        FROM submissions AS s
        RIGHT OUTER JOIN last_seven_days lsd
          ON s.date = lsd.date
          AND chart_id = ?
        ORDER BY lsd.date
      SQL
    end

    def weekly
      @scorables.each_slice(7).each_with_object({}) do |week, result|
        result.each_value do |v|
          v << 0
        end
        week.each do |submission|
          submission.submission_details.each do |sd|
            result[sd.item.name] ||= [0]
            result[sd.item.name][-1] +=1 if sd.checked?
          end
        end
        result.values.each { |v| v[-1] = (v[-1] / 0.07).round(2) }
      end.sort.to_a
    end

    private

    attr_reader :chart

    def daily_date_range
      last_scorable_day = if chart.submission_pending?
                            Time.zone.today - 1
                          else
                            Time.zone.today
                          end
      (last_scorable_day - 6)..last_scorable_day
    end
  end
end
