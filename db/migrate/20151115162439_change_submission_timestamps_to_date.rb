class ChangeSubmissionTimestampsToDate < ActiveRecord::Migration
  def change
    change_table :submissions do |t|
      t.remove_timestamps
      t.string :date
    end
  end
end
