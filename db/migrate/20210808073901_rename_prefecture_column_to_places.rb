class RenamePrefectureColumnToPlaces < ActiveRecord::Migration[6.1]
  def change
    rename_column :places, :prefecture, :prefecture_japan
    add_column :places, :prefecture_taiwan, :integer
  end
end
