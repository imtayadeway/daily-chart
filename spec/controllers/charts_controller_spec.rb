require "rails_helper"

RSpec.describe ChartsController, type: :controller do
  describe "#create" do
    it "can create a chart with some items" do
      sign_in
      post :create, chart: { items_attributes: [{ name: "Floss" }, { name: "Exercise" }] }
      chart = assigns[:chart]
      expect(chart.items.count).to eq(2)
      expect(chart.items.first.name).to eq("Floss")
      expect(chart.items.last.name).to eq("Exercise")
    end
  end
end
