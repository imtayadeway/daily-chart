class SubmissionsController < ApplicationController
  before_action :require_login

  def new
    @chart = current_user.chart
  end

  def create

  end
end
