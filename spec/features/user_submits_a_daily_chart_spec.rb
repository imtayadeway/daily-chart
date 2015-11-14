require "rails_helper"
require "support/features/clearance_helpers"

RSpec.feature "User submits a daily chart" do
  scenario "a chart has not yet been submitted for that day" do
    user = create(:user)
    user.create_chart(items_attributes: [{ name: "Floss" }, { name: "Exercise" }])

    visit new_submission_path(as: user)
    check "submission_Floss"
    check "submission_Exercise"
    click_button "Submit"

    expect(page).to have_content("Chart submitted for #{Time.zone.today}")
  end

  scenario "the user has already submitted a chart for that day" do
    user = create(:user)
    user.create_chart(items_attributes: [{ name: "Floss" }, { name: "Exercise" }])
    user.chart.submissions.create(data: { "Floss" => "1", "Exercise" => "1" })

    visit new_submission_path(as: user)
    check "submission_Floss"
    check "submission_Exercise"
    click_button "Submit"

    expect(page).to have_content("Chart already submitted for #{Time.zone.today}")
  end
end
