class AddDataToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :data, :json
  end
end
