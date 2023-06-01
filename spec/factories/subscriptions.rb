FactoryBot.define do
  factory :subscription do
    title { Faker::Coffee.blend_name }
    total_price { Faker::Number.between(from: 25, to: 200) }
    frequency { ["Weekly", "Bi-Weekly", "Monthly", "Quarterly", "Annually"].sample }
    status { 1 }
    customer { nil }
  end
end
