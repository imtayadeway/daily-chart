require "rails_helper"

RSpec.describe DashboardsController, type: :controller do
  it "takes me to the sign up page when not logged in" do
    get :show
    expect(response).to redirect_to(sign_in_path)
  end

  it "loads the dashboard if logged in with a chart" do
    user = create(:user)
    user.create_chart(items_attributes: [{ name: "Exercise" }])
    sign_in_as(user)
    get :show
    expect(response).to have_http_status(:ok)
  end

  it "takes me to the new chart page if logged in without a chart" do
    sign_in
    get :show
    expect(response).to redirect_to(new_chart_path)
  end
end
