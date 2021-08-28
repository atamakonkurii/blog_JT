class Article < ApplicationRecord
  belongs_to :user
  belongs_to :place

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture_japan
  belongs_to :prefecture_taiwan

  has_many :tags, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum main_language: { japanese: 0, taiwanese: 1, english: 2 }
  has_one_attached :title_image
end
