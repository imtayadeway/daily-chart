# == Schema Information
#
# Table name: charts
#
#  id      :integer          not null, primary key
#  user_id :integer
#

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

    it "counts today's score if submitted" do
      chart = Chart.create(items: [Item.new(name: "foo")])
      Timecop.freeze(Time.zone.today - 1) { chart.submissions.create(data: { "foo" => "1" }) }
      Timecop.freeze(Time.zone.today) { chart.submissions.create(data: { "foo" => "1" }) }

      expect(chart.scores).to eq([1, 1])
    end
  end

  describe "#percentages" do
    it "returns the percentage for each submissions" do
      chart = Chart.create(items: [Item.new(name: "foo")])
      Timecop.freeze(Time.zone.today - 3) { chart.submissions.create(data: { "foo" => "1" }) }
      Timecop.freeze(Time.zone.today - 2) { chart.submissions.create(data: { "foo" => "1" }) }
      Timecop.freeze(Time.zone.today - 1) { chart.submissions.create(data: { "foo" => "1" }) }

      expect(chart.percentages).to eq([100, 100, 100])
    end

    it "fills in days with no submission" do
      chart = Chart.create(items: [Item.new(name: "foo")])
      Timecop.freeze(Time.zone.today - 3) { chart.submissions.create(data: { "foo" => "1" }) }
      Timecop.freeze(Time.zone.today - 1) { chart.submissions.create(data: { "foo" => "1" }) }

      expect(chart.percentages).to eq([100, 0, 100])
    end

    it "counts today's percentage if submitted" do
      chart = Chart.create(items: [Item.new(name: "foo")])
      Timecop.freeze(Time.zone.today - 1) { chart.submissions.create(data: { "foo" => "1" }) }
      Timecop.freeze(Time.zone.today) { chart.submissions.create(data: { "foo" => "1" }) }

      expect(chart.percentages).to eq([100, 100])
    end
  end
end
