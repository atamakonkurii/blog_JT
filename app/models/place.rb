class Place < ApplicationRecord
  belongs_to :article

  enum country: { japan: 0, taiwan: 1, other: 2 }
end
