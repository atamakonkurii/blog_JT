class User < ApplicationRecord
  has_many :articles
  has_many :comments
  enum native_language: { japanese: 0, taiwanese: 1, english: 2 }

  # デフォルトの設定に、:omniauthable以下を追加
  devise :database_authenticatable,
         :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create(
      name: "dummy",
      uid: auth.uid,
      provider: auth.provider,
      email: User.dummy_email(auth),
      password: Devise.friendly_token[0, 20]
    )

    user
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
