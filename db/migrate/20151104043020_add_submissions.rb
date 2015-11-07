class AddSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :score
    end
  end
end
