require "rails_helper"

RSpec.describe Submission do
  describe "data" do
    it "is valid when the data matches the chart's items" do
      chart = Chart.create(items: [Item.new(name: "foo")])
      data = { "foo" => "1" }
      submission = chart.submissions.build(data: data)
      expect(submission).to be_valid
    end

    it "is invalid when the data does not match the chart's items" do
      chart = Chart.create(items: [Item.new(name: "foo")])
      data = { "bar" => "1" }
      submission = chart.submissions.build(data: data)
      expect(submission).to be_invalid
    end
  end

  describe "date" do
    specify "only one submission can be made per day" do
      chart = Chart.create(items: [Item.new(name: "foo")])

      Timecop.freeze(Time.zone.now.at_beginning_of_day) do
        chart.submissions.create(data: { "foo" => "1" })
      end

      Timecop.freeze(Time.zone.now.at_beginning_of_day + 1.minute) do
        submission = chart.submissions.create(data: { "foo" => "1" })
        expect(submission).to be_invalid
      end
    end
  end
end
