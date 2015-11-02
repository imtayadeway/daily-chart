require "rails_helper"

RSpec.feature "User Sign up" do
  scenario "creates an account with a valid credentials" do
    visit "/"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "abc123"
    click_button "Create Account"

    expect(page).to have_text("Account was successfully created")
  end
end
