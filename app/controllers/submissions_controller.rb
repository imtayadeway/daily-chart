class SubmissionsController < ApplicationController
  before_action :require_login

  def new
    @chart = current_chart
  end

  def create
    submission = current_chart.submissions.create(data: submission_params)
    if submission.valid?
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
