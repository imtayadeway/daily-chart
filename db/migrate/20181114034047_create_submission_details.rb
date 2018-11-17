class CreateSubmissionDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :submission_details do |t|
      t.integer :chart_id
      t.integer :submission_id
      t.integer :item_id
      t.boolean :checked
    end
  end
end
