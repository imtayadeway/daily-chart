class AddChartIdToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :chart_id, :integer
  end
end
