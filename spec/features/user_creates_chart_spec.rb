require "rails_helper"
require "support/features/clearance_helpers"

RSpec.feature "User creates a chart" do
  scenario "adding a chart with one items" do
    sign_in
    visit new_chart_path
    fill_in "chart_items_attributes_0_name", with: "Exercise"
    click_button("Submit")

    expect(page).to have_content("Created new chart")
  end

  scenario "the user already has a chart" do
    user = create(:user)
    user.create_chart(items_attributes: [{ name: "Exercise" }])
    visit new_chart_path(as: user)

    expect(page).to have_content("already have a chart")
  end
end
