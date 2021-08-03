class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 30
      t.string :email, null: false, limit: 255
      t.string :password_digest, null: false
      t.boolean :activated, null: false, default: false
      t.boolean :admin, null: false, default: false
      t.integer :native_language, null: false, default: 0

      t.timestamps
    end
  end
end
