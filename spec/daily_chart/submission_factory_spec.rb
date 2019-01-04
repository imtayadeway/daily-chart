require "rails_helper"

RSpec.describe DailyChart::SubmissionFactory do
  describe ".build" do
    it "builds a submission" do
      chart = create(:chart)
      submission = described_class.build(chart: chart)
      expect(submission).to be_kind_of(Submission)
    end

    it "checks off the passed in items" do
      boop = Item.new(name: "Boop")
      beep = Item.new(name: "Beep")
      chart = create(:chart, items: [boop, beep])

      submission = described_class.build(
        chart: chart,
        data: {"Boop" => true, "Beep" => false}
      )

      expect(submission.submission_details)
        .to include(an_object_having_attributes(item: boop, checked: true),
                    an_object_having_attributes(item: beep, checked: false))
    end

    it "raises if a checked item cannot be found" do
      boop = Item.new(name: "Boop")
      chart = create(:chart, items: [boop])

      expect {
        described_class.build(chart: chart, data: {"Beep" => true})
      }.to raise_error(/not found/)
    end

    it "raises if an unchecked items cannot be found" do
      boop = Item.new(name: "Boop")
      chart = create(:chart, items: [boop])

      expect {
        described_class.build(chart: chart, data: {"Beep" => false})
      }.to raise_error(/not found/)

    end

    it "raises unless all the items are present" do
      boop = Item.new(name: "Boop")
      chart = create(:chart, items: [boop])

      expect {
        described_class.build(chart: chart)
      }.to raise_error(/missing/i)
    end
  end
end
