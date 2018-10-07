module DailyChart
  class Stats
    def initialize(chart)
      @scorables = Scorables.for(ScorableDays.for(chart), chart.submissions.to_a)
    end

    def daily
      @scorables.last(7).map { |s| [s.weekday, s.percent] }
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
  end
end
