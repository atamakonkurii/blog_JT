class AddDetailsToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :article_id, :integer, null: false
  end
end
