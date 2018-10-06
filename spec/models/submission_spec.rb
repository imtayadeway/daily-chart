# == Schema Information
#
# Table name: submissions
#
#  id       :integer          not null, primary key
#  score    :integer
#  data     :json
#  chart_id :integer
#  date     :string
#

require "rails_helper"

RSpec.describe Submission do
  describe "#percent" do
    it "returns the score as a percentage of max score" do
      chart = Chart.create(items: [Item.new(name: "foo"), Item.new(name: "bar")])
      data = { "foo" => "1", "bar" => "0" }
      submission = chart.submissions.create(data: data)

      expect(submission.percent).to eq(50)
    end
  end

  describe "data" do
    it "is valid when the data matches the chart's items" do
      chart = Chart.create(items: [Item.new(name: "foo")])
      data = { "foo" => "1" }
      submission = chart.submissions.create(data: data)
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
      chart.submissions.create(data: { "foo" => "1" }, date: Date.parse("2018-01-01"))

      submission = chart.submissions.create(data: { "foo" => "1" }, date: Date.parse("2018-01-01"))

      expect(submission).to be_invalid
    end

    specify "creating a submission sets today's date on it" do
      chart = Chart.create(items: [Item.new(name: "foo")])

      Timecop.freeze do
        submission = chart.submissions.create(data: { "foo" => "1" })
        expect(submission.date).to eq(Time.zone.today)
      end
    end

    specify "a date can optionally be passed to a submission" do
      date = 5.days.ago.to_date
      chart = Chart.create(items: [Item.new(name: "foo")])
      submission = chart.submissions.create(data: { "foo" => "1" }, date: date)
      expect(submission.date).to eq(date)
    end
  end
end
