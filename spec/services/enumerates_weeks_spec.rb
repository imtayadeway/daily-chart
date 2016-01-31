require_relative "../../app/services/enumerates_weeks"
require "spec_helper"

RSpec.describe EnumeratesWeeks do
  it "returns 1 for zero days" do
    expect(described_class.for(0)).to eq [1]
  end

  it "returns 1 for six days" do
    expect(described_class.for(6)).to eq [1]
  end

  it "returns 1, 2 for seven days" do
    expect(described_class.for(7)).to eq [1, 2]
  end
end
