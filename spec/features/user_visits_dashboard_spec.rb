require "rails_helper"

RSpec.feature "user visits dashboard" do
  scenario "not having submitted a chart for today" do
    user = create(:user)
    user.create_chart(items_attributes: [{ name: "Exercise" }])

    visit dashboard_path(as: user)

    expect(page).to have_link("Submit today's chart", href: new_submission_path)
  end

  scenario "having submitted a chart for today" do
    user = create(:user)
    chart = user.create_chart
    exercise = chart.items.create(name: "Exercise")
    submission = chart.submissions.new
    submission.submission_details.new(chart: chart, item: exercise, checked: true)
    submission.save!

    visit dashboard_path(as: user)

    expect(page).to have_no_link("Submit today's chart", href: new_submission_path)
  end
end
