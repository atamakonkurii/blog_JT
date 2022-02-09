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
FactoryBot.define do
  factory :place do
    country { 1 }
    prefecture { 1 }
    article_id { 1 }
  end
end
