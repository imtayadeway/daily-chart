require "active_support/core_ext/time"
Time.zone ||= "UTC"
require_relative "../../app/models/scorable_days"
require "spec_helper"

RSpec.describe ScorableDays do
  describe ".for" do
    it "is empty if there have been no submissions" do
      chart = double("chart", submissions: [])

      expect(described_class.for(chart)).to be_empty
    end

    it "includes the submission date if there has been a submission" do
      submission_date = Time.zone.today - 1
      submission = double("submission", date: submission_date)
      chart = double("chart", submissions: [submission], submission_pending?: true)

      expect(described_class.for(chart).to_a).to eq([submission_date])
    end

    it "includes today if it has been submitted" do
      submission_date = Time.zone.today
      submission = double("submission", date: submission_date)
      chart = double("chart", submissions: [submission], submission_pending?: false)

      expect(described_class.for(chart).to_a).to eq([submission_date])
    end
  end
end
