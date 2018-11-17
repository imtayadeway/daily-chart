class ChangeSubmissionTimestampsToDate < ActiveRecord::Migration[4.2]
  def change
    change_table :submissions do |t|
      t.remove_timestamps
      t.string :date
    end
  end
end
