class Article < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture_japan
  belongs_to :prefecture_taiwan

  has_one :place, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum main_language: { japanese: 0, taiwanese: 1, english: 2 }
end
