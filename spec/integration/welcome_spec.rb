require "rails_helper"

RSpec.describe "Welcome", type: :request do
  it "takes me to the sign up page" do
    get root_url
    expect(response).to redirect_to(sign_up_path)
  end

  it "takes me to the dashboard if logged in with a chart" do
    user = create(:user)
    user.create_chart(items_attributes: [{ name: "Exercise" }])
    get root_url, params: { as: user.id }
    expect(response).to redirect_to(dashboard_path)
  end

  it "takes me to the new chart page if logged in without a chart" do
    user = create(:user)
    get root_url, params: { as: user.id }
    expect(response).to redirect_to(new_chart_path)
  end
end
