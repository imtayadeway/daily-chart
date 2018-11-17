class AddDateToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_timestamps :submissions
  end
end
