require "rails_helper"

RSpec.describe Submission do
  describe "#percent" do
    it "returns the score as a percentage of max score" do
      chart = create(:chart, items_attributes: [{name: "foo"}, {name: "bar"}])
      submission = DailyChart.create_submission(
        chart: chart,
        data: {"foo" => true, "bar" => false}
      )

      expect(submission.percent).to eq(50)
    end
  end

  describe "data" do
    it "is valid when the data matches the chart's items" do
      foo = Item.new(name: "foo")
      chart = create(:chart, items: [foo])
      submission = chart.submissions.new
      submission.submission_details.new(chart: chart, item: foo, checked: true)

      expect(submission).to be_valid
    end

    it "is invalid when the data does not match the chart's items" do
      chart = create(:chart, items_attributes: [{name: "foo"}])
      submission = chart.submissions.new
      submission.submission_details.new(chart: chart, item: nil, checked: true)
      expect(submission).to be_invalid
    end
  end

  describe "date" do
    specify "only one submission can be made per day" do
      chart = create(:chart, items_attributes: [{name: "foo"}])
      chart.submissions.create(date: Date.parse("2018-01-01"))

      submission = chart.submissions.create(date: Date.parse("2018-01-01"))

      expect(submission).to be_invalid
    end

    specify "creating a submission sets today's date on it" do
      chart = create(:chart, items_attributes: [{name: "foo"}])

      Timecop.freeze do
        submission = chart.submissions.create
        expect(submission.date).to eq(Time.zone.today)
      end
    end

    specify "a date can optionally be passed to a submission" do
      date = 5.days.ago.to_date
      chart = create(:chart, items_attributes: [{name: "foo"}])
      submission = chart.submissions.create(date: date)
      expect(submission.date).to eq(date)
    end
  end
end
