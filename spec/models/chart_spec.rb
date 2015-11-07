require "rails_helper"

RSpec.describe Chart do
  describe "#scores" do
    it "returns the score for each submissions" do
      chart = Chart.create(items: [Item.new(name: "foo")])
      Timecop.freeze(Time.zone.today - 3) { chart.submissions.create(data: { "foo" => "1" }) }
      Timecop.freeze(Time.zone.today - 2) { chart.submissions.create(data: { "foo" => "1" }) }
      Timecop.freeze(Time.zone.today - 1) { chart.submissions.create(data: { "foo" => "1" }) }

      expect(chart.scores).to eq([1, 1, 1])
    end

    it "fills in days with no submission" do
      chart = Chart.create(items: [Item.new(name: "foo")])
      Timecop.freeze(Time.zone.today - 3) { chart.submissions.create(data: { "foo" => "1" }) }
      Timecop.freeze(Time.zone.today - 1) { chart.submissions.create(data: { "foo" => "1" }) }

      expect(chart.scores).to eq([1, 0, 1])
    end
  end
end
