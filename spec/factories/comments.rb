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
FactoryBot.define do
  factory :comment do
    content { "MyText" }
    user_id { 1 }
    article_id { 1 }
  end
end
