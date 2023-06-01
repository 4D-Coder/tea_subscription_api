FactoryBot.define do
  factory :tea do
    description { Faker::Tea.variety }
    temperature { Faker::Number.between(from: 100, to: 150) }
    brew_time { [60, 90, 120, 150, 180].sample }
    unit_price { Faker::Number.between(from: 25, to: 200) }
  end
end
