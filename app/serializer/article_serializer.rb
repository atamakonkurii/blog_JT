class ArticleSerializer
  include JSONAPI::Serializer
  belongs_to :user

  attributes :title_ja, :title_zh_tw, :content_ja, :content_zh_tw, :title_image, :created_at
end
