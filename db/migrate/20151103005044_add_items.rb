class AddItems < ActiveRecord::Migration[4.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :chart_id
    end
  end
end
