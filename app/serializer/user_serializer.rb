class UserSerializer
  include JSONAPI::Serializer
  has_many :articles

  attribute :name, :avatar
end
