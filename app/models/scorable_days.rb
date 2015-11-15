class ScorableDays
  def self.for(chart)
    case chart.submissions.size
    when 0
      []
    when 1
      chart.submissions.map(&:date)
    else
      last_scorable_day = chart.submission_pending? ? Time.zone.today - 1 : Time.zone.today
      chart.submissions.first.date..last_scorable_day
    end
  end
end
