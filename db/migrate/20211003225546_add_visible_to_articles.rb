class AddVisibleToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :visible_list, :boolean, null: false, default: true
  end
end
