require "rails_helper"

RSpec.describe Dashboard do
  describe "#last_seven_days" do
    it "counts today if it's been submitted" do
      chart = Chart.create(items: [Item.new(name: "foo")])
      6.downto(0) do |n|
        chart.submissions.create(data: { "foo" => "1" }, date: Time.zone.today - n)
      end
      dashboard = Dashboard.new(chart)

      expect(dashboard.last_seven_days.last).to eq(Time.zone.today.strftime("%a"))
    end

    it "does not count today if a submission is pending" do
      chart = Chart.create(items: [Item.new(name: "foo")])
      7.downto(1) do |n|
        chart.submissions.create(data: { "foo" => "1" }, date: Time.zone.today - n)
      end
      dashboard = Dashboard.new(chart)

      expect(dashboard.last_seven_days.last).to eq((Time.zone.yesterday).strftime("%a"))
    end
  end
end
