class AddDetailsArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :title_image, :string
  end
end
