class ScorableDays
  def self.for(chart)
    return [] if chart.submissions.size.zero?
    last_scorable_day = chart.submission_pending? ? Time.zone.today - 1 : Time.zone.today
    chart.submissions.first.date..last_scorable_day
  end
end
