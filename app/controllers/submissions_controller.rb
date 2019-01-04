class SubmissionsController < ApplicationController
  before_action :require_login

  def new
    @chart = current_chart
  end

  def create
    submission = DailyChart.build_submission(
      chart: current_chart,
      data: submission_params.to_h.transform_values { |v| v == "1" }
    )

    if submission.save
      flash[:notice] = "Chart submitted for #{Time.zone.today}"
    else
      flash[:alert] = "Chart already submitted for #{Time.zone.today}"
    end
    redirect_to dashboard_path
  end

  private

  def submission_params
    params.require(:submission).permit(current_item_names)
  end

  def current_item_names
    current_chart.items.map(&:name)
  end
end
