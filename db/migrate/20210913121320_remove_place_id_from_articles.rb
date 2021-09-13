class RemovePlaceIdFromArticles < ActiveRecord::Migration[6.1]
  def change
    remove_column :articles, :place_id, :integer
  end
end
