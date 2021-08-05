class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.integer :name, null: false
      t.integer :article_id, null: false

      t.timestamps
    end
  end
end
