class AddSubmissions < ActiveRecord::Migration[4.2]
  def change
    create_table :submissions do |t|
      t.integer :score
    end
  end
end
