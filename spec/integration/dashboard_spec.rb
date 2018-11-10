require "rails_helper"

RSpec.describe "Dashboards", type: :request do
  it "takes me to the sign up page when not logged in" do
    get dashboard_url
    expect(response).to redirect_to(sign_in_path)
  end

  it "loads the dashboard if logged in with a chart" do
    user = create(:user)
    user.create_chart(items_attributes: [{ name: "Exercise" }])
    get dashboard_url, params: { as: user.id }
    expect(response).to have_http_status(:ok)
  end

  it "takes me to the new chart page if logged in without a chart" do
    user = create(:user)
    get dashboard_url, params: { as: user.id }
    expect(response).to redirect_to(new_chart_path)
  end
end
