class AddChartIdToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :chart_id, :integer
  end
end
