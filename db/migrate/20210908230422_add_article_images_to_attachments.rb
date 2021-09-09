class AddArticleImagesToAttachments < ActiveRecord::Migration[6.1]
  def change
    add_column :attachments, :article_image, :string
  end
end
