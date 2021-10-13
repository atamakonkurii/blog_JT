class AddSns2ToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :youtube, :text
  end
end
