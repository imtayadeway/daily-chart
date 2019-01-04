module DailyChart
  def self.build_submission(**args)
    SubmissionFactory.build(**args)
  end

  def self.create_submission(**args)
    SubmissionFactory.create(**args)
  end
end
