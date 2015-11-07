require_relative "../../app/models/checks_submission_data"
require "spec_helper"

RSpec.describe ChecksSubmissionData do
  it "is valid when the data keys match the item names" do
    chart = double("Chart", item_names: ["foo"])
    data = { "foo" => "1" }
    expect(described_class.ok?(chart, data)).to be true
  end

  it " is valid when the data keys match the item names but in a different order" do
    chart = double("Chart", item_names: %w(foo bar))
    data = { "bar" => "0", "foo" => "1" }
    expect(described_class.ok?(chart, data)).to be true
  end

  it "is invalid if the values are not all either '1' or '0'" do
    chart = double("Chart", item_names: ["foo"])
    data = { "foo" => "bar" }
    expect(described_class.ok?(chart, data)).to be false
  end

  it "is invalid if the data has keys that are not in the item names" do
    chart = double("Chart", item_names: ["foo"])
    data = { "foo" => "1", "bar" => "0" }
    expect(described_class.ok?(chart, data)).to be false
  end

  it "is invalid if the data does not have all the keys" do
    chart = double("Chart", item_names: %w(foo bar))
    data = { "foo" => "1" }
    expect(described_class.ok?(chart, data)).to be false
  end
end
