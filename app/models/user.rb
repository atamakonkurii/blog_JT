class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :password_digest, presence: true, length: { minimum: 3, maximum: 72 }
end
