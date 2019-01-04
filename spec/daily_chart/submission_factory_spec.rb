require "rails_helper"

RSpec.describe DailyChart::SubmissionFactory do
  describe "#build" do
    it "builds a submission" do
      chart = create(:chart)
      submission = described_class.new(chart: chart).build
      expect(submission).to be_kind_of(Submission)
    end

    it "checks off the passed in items" do
      boop = Item.new(name: "Boop")
      beep = Item.new(name: "Beep")
      chart = create(:chart, items: [boop, beep])

      submission = described_class.new(
        chart: chart,
        data: {"Boop" => true, "Beep" => false}
      ).build

      expect(submission.submission_details)
        .to include(an_object_having_attributes(item: boop, checked: true),
                    an_object_having_attributes(item: beep, checked: false))
    end

    it "accepts a date" do
      date = Date.new(2019, 1, 1)
      chart = create(:chart)
      submission = described_class.new(chart: chart, date: date).build
      expect(submission.date).to eq date
    end

    it "raises if a checked item cannot be found" do
      chart = create(:chart, items_attributes: [{name: "Boop"}])

      expect {
        described_class.new(chart: chart, data: {"Beep" => true}).build
      }.to raise_error(/not found/)
    end

    it "raises if an unchecked items cannot be found" do
      chart = create(:chart, items_attributes: [{name: "Boop"}])

      expect {
        described_class.new(chart: chart, data: {"Beep" => false}).build
      }.to raise_error(/not found/)

    end

    it "raises unless all the items are present" do
      chart = create(:chart, items_attributes: [{name: "Boop"}])

      expect {
        described_class.new(chart: chart).build
      }.to raise_error(/missing/i)
    end
  end
end
