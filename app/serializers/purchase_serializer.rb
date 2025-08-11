class PurchaseSerializer
  include JSONAPI::Serializer

  attributes :id, :amount_cents, :country, :created_at, :updated_at

  attribute :amount do |object|
    # Assuming you use money-rails and amount_cents is stored in cents
    Money.new(object.amount_cents, "USD").format
  end
end
