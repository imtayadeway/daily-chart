require "rails_helper"

RSpec.describe DailyChart::SubmissionFactory do
  describe ".build" do
    it "builds a submission" do
      chart = Chart.create!(user: create(:user))
      submission = described_class.build(chart: chart)
      expect(submission).to be_kind_of(Submission)
    end

    it "checks off the passed in items" do
      boop = Item.new(name: "Boop")
      beep = Item.new(name: "Beep")
      chart = Chart.create!(user: create(:user), items: [boop, beep])

      submission = described_class.build(
        chart: chart,
        checked: ["Boop"],
        unchecked: ["Beep"]
      )

      expect(submission.submission_details)
        .to include(an_object_having_attributes(item: boop, checked: true),
                    an_object_having_attributes(item: beep, checked: false))
    end

    it "raises if a checked item cannot be found" do
      boop = Item.new(name: "Boop")
      chart = Chart.create(user: create(:user), items: [boop])

      expect {
        described_class.build(chart: chart, checked: ["Beep"])
      }.to raise_error(/not found/)
    end

    it "raises if an unchecked items cannot be found" do
      boop = Item.new(name: "Boop")
      chart = Chart.create(user: create(:user), items: [boop])

      expect {
        described_class.build(chart: chart, unchecked: ["Beep"])
      }.to raise_error(/not found/)

    end

    it "raises unless all the items are present" do
      boop = Item.new(name: "Boop")
      chart = Chart.create(user: create(:user), items: [boop])

      expect {
        described_class.build(chart: chart)
      }.to raise_error(/missing/i)
    end

    it "raises if there is an overlap between checked and unchecked" do
      boop = Item.new(name: "Boop")
      chart = Chart.create(user: create(:user), items: [boop])

      expect {
        described_class.build(chart: chart, checked: ["Boop"], unchecked: ["Boop"])
      }.to raise_error(/overlap/i)

    end
  end
end