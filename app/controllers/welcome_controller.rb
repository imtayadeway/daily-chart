class WelcomeController < ApplicationController
  def index
    if signed_in?
      if current_chart
        redirect_to dashboard_path
      else
        redirect_to new_chart_path
      end
    else
      redirect_to sign_up_path
    end
  end
end
