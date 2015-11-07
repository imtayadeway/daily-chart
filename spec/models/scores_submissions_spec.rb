require_relative "../../app/models/scores_submissions"
require "spec_helper"

RSpec.describe ScoresSubmissions do
  it "scores a submission" do
    data = { "foo" => "1", "bar" => "0", "baz" => "1" }
    expect(described_class.score(data)).to eq(2)
  end
end
