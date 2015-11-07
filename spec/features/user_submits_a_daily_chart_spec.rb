require "rails_helper"
require "support/features/clearance_helpers"

RSpec.feature "User submits a daily chart" do
  scenario "happy path" do
    user = create(:user)
    user.create_chart(items_attributes: [{ name: "Floss" }, { name: "Exercise" }])
    visit new_submission_path(as: user)
    check "submission_Floss"
    check "submission_Exercise"
    click_button "Submit"

    expect(page).to have_content("Chart submitted for #{Time.zone.today}")
  end
end
