# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :integer          not null
#  user_id    :integer          not null
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
end
