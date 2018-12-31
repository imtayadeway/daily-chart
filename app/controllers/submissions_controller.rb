class SubmissionsController < ApplicationController
  before_action :require_login

  def new
    @chart = current_chart
  end

  def create
    submission = current_chart.submissions.new
    submission_params.each do |name, checked|
      item = current_chart.items.find_by(name: name)
      submission.submission_details.new(
        chart: current_chart,
        item: item,
        checked: checked == "1"
      )
    end
    if submission.save
      flash[:notice] = "Chart submitted for #{Time.zone.today}"
    else
      flash[:alert] = "Chart already submitted for #{Time.zone.today}"
    end
    redirect_to dashboard_path
  end

  private

  def submission_params
    params.require(:submission)
  end
end
