class ChartsController < ApplicationController
  before_action :require_login

  def new
    @chart = Chart.new
    2.times { @chart.items.build }
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
