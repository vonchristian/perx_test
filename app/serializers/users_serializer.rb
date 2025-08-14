class UsersSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :name, :birth_date, :country, :first_purchase_at
  has_many :rewards, serializer: RewardsSerializer
end
