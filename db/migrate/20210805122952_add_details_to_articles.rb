class AddDetailsToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :title_zh_tw, :string
    add_column :articles, :content_zh_tw, :text
    add_column :articles, :title_en, :string
    add_column :articles, :content_en, :text
    add_column :articles, :main_language, :integer, null: false
    add_column :articles, :user_id, :integer, null: false
  end
end
