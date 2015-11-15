class DashboardsController < ApplicationController
  def show
    @dashboard = Dashboard.new(current_chart)
  end
end
