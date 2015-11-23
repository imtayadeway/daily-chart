require_relative "../../app/models/score"
require_relative "../../app/models/collects_scores"
require "spec_helper"

RSpec.describe CollectsScores do
  describe ".all_time" do
    it "collects the score for each scorable day" do
      first_day = Date.today - 2
      last_day = Date.today - 1
      scorable_days = first_day..last_day
      submitted_scores = [
        double("submission 1", date: first_day, score: 1),
        double("submission 2", date: last_day, score: 1)
      ]
      actual = described_class.all_time(scorable_days, submitted_scores)

      expect(actual.map(&:value)).to eq([1, 1])
    end

    it "accounts for days between submissions" do
      first_day = Date.today - 3
      last_day = Date.today - 1
      scorable_days = first_day..last_day
      submitted_scores = [
        double("submission 1", date: first_day, score: 1),
        double("submission 2", date: last_day, score: 1)
      ]
      actual = described_class.all_time(scorable_days, submitted_scores)

      expect(actual.map(&:value)).to eq([1, 0, 1])
    end

    it "accounts for days since the last submission" do
      first_day = Date.today - 3
      second_day = Date.today - 2
      last_day = Date.today - 1
      scorable_days = first_day..last_day
      submitted_scores = [
        double("submission 1", date: first_day, score: 1),
        double("submission 2", date: second_day, score: 1)
      ]
      actual = described_class.all_time(scorable_days, submitted_scores)

      expect(actual.map(&:value)).to eq([1, 1, 0])
    end
  end
end
