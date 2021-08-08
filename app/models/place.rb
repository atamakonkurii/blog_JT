class Place < ApplicationRecord
  has_one :article, dependent: :destroy

  enum country: { japan: 0, taiwan: 1, other: 2 }
end
