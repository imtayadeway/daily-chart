require_relative "../../app/models/calculates_averages"
require "spec_helper"

RSpec.describe CalculatesAverages do
  it "calculates the average for one day" do
    scorables = [double("scorable", percent: 50)]
    expect(described_class.for(scorables)).to eq [50]
  end

  it "calculates the average for two days" do
    scorables = [double("scorable 1", percent: 25), double("scorable 2", percent: 75)]
    expect(described_class.for(scorables)).to eq [50]
  end

  it "calculates the average for seven days" do
    scorables = [
      double("scorable 1", percent: 10),
      double("scorable 2", percent: 20),
      double("scorable 3", percent: 30),
      double("scorable 4", percent: 40),
      double("scorable 5", percent: 50),
      double("scorable 6", percent: 60),
      double("scorable 7", percent: 70)
    ]

    expect(described_class.for(scorables)).to eq [40]
  end

  it "calculates the averages for eight days" do
    scorables = [
      double("scorable 1", percent: 10),
      double("scorable 2", percent: 20),
      double("scorable 3", percent: 30),
      double("scorable 4", percent: 40),
      double("scorable 5", percent: 50),
      double("scorable 6", percent: 60),
      double("scorable 7", percent: 70),
      double("scorable 8", percent: 80)
    ]

    expect(described_class.for(scorables)).to eq [40, 80]
  end
end
