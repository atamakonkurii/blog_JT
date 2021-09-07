class ArticleImage < ApplicationRecord
  mount_uploader :article_image, ArticleImageUploader
end