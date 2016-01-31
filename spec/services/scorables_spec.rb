require_relative "../../app/services/scorables"
require "date_formatters"
require_relative "../../app/models/no_submission"
require "active_support/core_ext/time"
Time.zone ||= "UTC"
require "spec_helper"

RSpec.describe Scorables do
  describe ".for" do
    it "collects the scorables for each scorable day" do
      first_day = Time.zone.today - 2
      last_day = Time.zone.today - 1
      scorable_days = first_day..last_day
      submissions = [
        double("submission 1", date: first_day, score: 1),
        double("submission 2", date: last_day, score: 1)
      ]
      actual = described_class.for(scorable_days, submissions)

      expect(actual.map(&:score)).to eq([1, 1])
    end

    it "accounts for days between submissions" do
      first_day = Time.zone.today - 3
      last_day = Time.zone.today - 1
      scorable_days = first_day..last_day
      submissions = [
        double("submission 1", date: first_day, score: 1),
        double("submission 2", date: last_day, score: 1)
      ]
      actual = described_class.for(scorable_days, submissions)

      expect(actual.map(&:score)).to eq([1, 0, 1])
    end

    it "accounts for days since the last submission" do
      first_day = Time.zone.today - 3
      second_day = Time.zone.today - 2
      last_day = Time.zone.today - 1
      scorable_days = first_day..last_day
      submissions = [
        double("submission 1", date: first_day, score: 1),
        double("submission 2", date: second_day, score: 1)
      ]
      actual = described_class.for(scorable_days, submissions)

      expect(actual.map(&:score)).to eq([1, 1, 0])
    end
  end
end
