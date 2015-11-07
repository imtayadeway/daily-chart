class ScoresSubmissions
  def self.score(submission)
    submission.values.count { |value| value == "1" }
  end
end
