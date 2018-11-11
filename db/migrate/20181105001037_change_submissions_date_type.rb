class ChangeSubmissionsDateType < ActiveRecord::Migration[6.0]
  def up
    connection.execute(<<~SQL)
      ALTER TABLE "submissions"
      ALTER COLUMN "date"
      TYPE date
      USING date::date
    SQL
  end

  def down
    change_column :submissions, :date, :string
  end
end
