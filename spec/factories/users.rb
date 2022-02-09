# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  activated              :boolean          default(FALSE), not null
#  admin                  :boolean          default(FALSE), not null
#  amazon                 :text(65535)
#  avatar                 :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  facebook               :text(65535)
#  instagram              :text(65535)
#  name                   :string(30)
#  native_language        :integer          default("japanese"), not null
#  provider               :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  self_introduction      :string(255)
#  twitter                :text(65535)
#  uid                    :string(255)
#  youtube                :text(65535)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    name { "Kazuki" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "AaBb1234" }
  end
end
