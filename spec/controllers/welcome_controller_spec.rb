require "rails_helper"

RSpec.describe WelcomeController, type: :controller do
  it "takes me to the sign up page" do
    get :index
    expect(response).to redirect_to(sign_up_path)
  end

  it "takes me to the dashboard if logged in with a chart" do
    user = create(:user)
    user.create_chart(items_attributes: [{ name: "Exercise" }])
    sign_in_as(user)
    get :index
    expect(response).to redirect_to(dashboard_path)
  end

  it "takes me to the new chart page if logged in without a chart" do
    sign_in
    get :index
    expect(response).to redirect_to(new_chart_path)
  end
end
