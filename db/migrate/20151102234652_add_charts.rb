class AddCharts < ActiveRecord::Migration
  def change
    create_table :charts do |t|
      t.integer :user_id
    end
  end
end
