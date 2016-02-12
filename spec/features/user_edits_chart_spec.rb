require "rails_helper"
require "support/features/clearance_helpers"

RSpec.feature "user edits a chart" do
  scenario "will see a link to edit the chart on the dashboard" do
    user = create_user_and_chart_with_items(name: "Exercise")

    visit dashboard_path(as: user)

    expect(page).to have_link "Edit", href: edit_chart_path
  end

  scenario "editing an item" do
    user = create_user_and_chart_with_items(name: "Exercise")

    visit edit_chart_path(as: user)
    fill_in "chart_items_attributes_0_name", with: "Exercise 30 mins"
    click_button("Submit")

    expect(page).to have_content("Edited chart")
  end

  def create_user_and_chart_with_items(*items)
    user = create(:user)
    user.create_chart(items_attributes: items.map { |item_name| { name: item_name }})
    user
  end
end
