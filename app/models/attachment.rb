# == Schema Information
#
# Table name: attachments
#
#  id            :bigint           not null, primary key
#  article_image :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Attachment < ApplicationRecord
  mount_uploader :article_image, ArticleImageUploader
end
