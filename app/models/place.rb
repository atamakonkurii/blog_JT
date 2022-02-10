# == Schema Information
#
# Table name: places
#
#  id                   :bigint           not null, primary key
#  country              :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  article_id           :integer          not null
#  prefecture_japan_id  :integer
#  prefecture_taiwan_id :integer
#
class Place < ApplicationRecord
  belongs_to :article

  enum country: { japan: 0, taiwan: 1, other: 2 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture_japan
  belongs_to :prefecture_taiwan
end
