class RenameTitleColumnToArticles < ActiveRecord::Migration[6.1]
  def change
    rename_column :articles, :title, :title_ja
    rename_column :articles, :content, :content_ja
  end
end
