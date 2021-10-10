class AddSnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :facebook, :text
    add_column :users, :twitter, :text
    add_column :users, :instagram, :text
    add_column :users, :amazon, :text
  end
end
