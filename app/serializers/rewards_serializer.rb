class RewardsSerializer
  include JSONAPI::Serializer

  attributes :id, :reward_type, :reason, :awarded_at
end
