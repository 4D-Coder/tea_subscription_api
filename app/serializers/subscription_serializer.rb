class SubscriptionSerializer
  include JSONAPI::Serializer

  attributes  :title,
              :total_price,
              :frequency,
              :status

  attribute :teas do |subscription|
    subscription.teas.map do |tea|
      TeaSerializer.new(tea)
    end
  end
end
