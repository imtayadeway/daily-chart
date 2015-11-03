class AddItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :chart_id
    end
  end
end
