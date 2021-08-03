FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
    activated { false }
    admin { false }
    native_language { 1 }
  end
end
