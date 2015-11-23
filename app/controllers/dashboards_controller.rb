class DashboardsController < ApplicationController
  before_action :require_login, :require_chart

  def show
    @dashboard = Dashboard.new(current_chart)
  end

  private

  def require_chart
    redirect_to new_chart_path unless current_chart
  end
end
