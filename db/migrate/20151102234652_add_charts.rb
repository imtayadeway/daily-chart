class AddCharts < ActiveRecord::Migration[4.2]
  def change
    create_table :charts do |t|
      t.integer :user_id
    end
  end
end
