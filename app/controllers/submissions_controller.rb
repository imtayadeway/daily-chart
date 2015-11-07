class SubmissionsController < ApplicationController
  before_action :require_login

  def new
    @chart = current_user.chart
  end

  def create
    current_user.chart.submissions.create(data: submission_params)
  end

  private

  def submission_params
    params.require(:submission)
  end
end
