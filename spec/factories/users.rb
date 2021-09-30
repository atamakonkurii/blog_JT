FactoryBot.define do
  factory :user do
    name { "Kazuki" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "AaBb1234" }
  end
end
