class Scorables
  def self.for(scorable_days, submissions)
    scorable_days.map do |date|
      if submissions.any? && submissions.first.date == date
        submissions.shift
      else
        NoSubmission.new(date)
      end
    end
  end
end
