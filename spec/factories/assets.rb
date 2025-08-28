# == Schema Information
#
# Table name: assets
#
#  id         :bigint           not null, primary key
#  avg_cost   :decimal(, )
#  category   :integer
#  currency   :string
#  name       :string
#  quantity   :decimal(, )
#  ticker     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :asset do
    name { Faker::Company.name }
    category { :stock }
    ticker { "2330" }
    quantity { rand(1..100) }
    avg_cost { rand(100..500) }
    currency { "TWD" }

    trait :us_stock do
      name { "Figma" }
      ticker { "FIG" }
      currency { "USD" }
    end

    trait :cash do
      name { "現金" }
      category { :cash }
      ticker { "CASH" }
      quantity { 20000 }
      avg_cost { 1 }
      currency { "TWD" }
    end
  end
end
