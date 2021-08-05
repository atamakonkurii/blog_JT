class Article < ApplicationRecord
  belongs_to :user

  has_one :place, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :comments, dependent: :destroy
end
