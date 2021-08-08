class RemoveArticleIdFromPlaces < ActiveRecord::Migration[6.1]
  def change
    remove_column :places, :article_id, :integer
    add_column :articles, :place_id, :integer, null: false
  end
end
