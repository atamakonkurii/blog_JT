class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.integer :country, null: false
      t.integer :prefecture
      t.integer :article_id, null: false

      t.timestamps
    end
  end
end
