FactoryBot.define do
  factory :comment do
    content { "MyText" }
    user_id { 1 }
    article_id { 1 }
  end
end
