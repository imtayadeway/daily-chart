require "rails_helper"
require "support/features/clearance_helpers"

RSpec.feature "User creates a chart" do
  scenario "happy path" do
    sign_in
    visit new_chart_path
    click_button "Add an item"
    fill_in "chart_items_attributes_0_name", with: "Floss"
    click_button "Add an item"
    fill_in "chart_items_attributes_1_name", with: "Exercise"
    click_button("Submit")

    expect(page).to have_content("Created new chart")
  end
end
