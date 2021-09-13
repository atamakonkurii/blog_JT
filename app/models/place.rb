class Place < ApplicationRecord
  belongs_to :article

  enum country: { japan: 0, taiwan: 1, other: 2 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture_japan
  belongs_to :prefecture_taiwan
end
