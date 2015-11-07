class AddDataToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :data, :json
  end
end
