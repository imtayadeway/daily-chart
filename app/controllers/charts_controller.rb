class ChartsController < ApplicationController
  before_action :require_login

  def new
    if current_chart
      flash[:alert] = "You already have a chart"
      redirect_to dashboard_path
    else
      @chart = Chart.new
      2.times { @chart.items.build }
    end
  end

  def create
    @chart = current_user.build_chart(chart_params)
    if @chart.save
      redirect_to @chart
    else
      render :new
    end
  end

  def show
  end

  private

  def chart_params
    params.require(:chart).permit(items_attributes: [:name])
  end
end
