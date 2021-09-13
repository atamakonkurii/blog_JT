class Article < ApplicationRecord
  belongs_to :user
  has_one :place, dependent: :destroy
  accepts_nested_attributes_for :place

  has_many :tags, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum main_language: { japanese: 0, taiwanese: 1, english: 2 }

  mount_uploader :title_image, TitleImageUploader
end
