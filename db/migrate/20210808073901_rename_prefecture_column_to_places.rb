class RenamePrefectureColumnToPlaces < ActiveRecord::Migration[6.1]
  def change
    rename_column :places, :prefecture, :prefecture_japan_id
    add_column :places, :prefecture_taiwan_id, :integer
  end
end
