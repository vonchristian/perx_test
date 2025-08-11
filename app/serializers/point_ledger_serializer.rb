class PointLedgerSerializer
  include JSONAPI::Serializer

  attributes :id, :points, :created_at, :updated_at
end
