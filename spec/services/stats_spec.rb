require_relative "../../app/services/stats"
require "spec_helper"

RSpec.describe Stats do
  describe "#best_item" do
    it "finds the best item" do
      scorable = double("scorable")
      allow(scorable).to receive(:score_for).with("Washing up").and_return(1)
      allow(scorable).to receive(:score_for).with("Tidy room").and_return(2)
      items = [double("item 1", name: "Washing up"), double("item 2", name: "Tidy room")]
      stats = described_class.new([scorable], items)

      expect(stats.best_item).to eq "Tidy room"
    end
  end

  describe "#worst_item" do
    it "finds the worst item" do
      scorable = double("scorable")
      allow(scorable).to receive(:score_for).with("Washing up").and_return(1)
      allow(scorable).to receive(:score_for).with("Tidy room").and_return(2)
      items = [double("item 1", name: "Washing up"), double("item 2", name: "Tidy room")]
      stats = described_class.new([scorable], items)

      expect(stats.worst_item).to eq "Washing up"
    end
  end
end
