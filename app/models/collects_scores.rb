class CollectsScores
  def self.all_time(scorable_days, submitted_scores)
    scorable_days.map do |date|
      value = if submitted_scores.any? && submitted_scores.first.date == date
                submitted_scores.shift.score
              else
                0
              end
      Score.new(date, value)
    end
  end
end
