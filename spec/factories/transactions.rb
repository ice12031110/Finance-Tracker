# == Schema Information
#
# Table name: transactions
#
#  id         :bigint           not null, primary key
#  action     :string           not null
#  amount     :decimal(, )      default(0.0)
#  date       :date             not null
#  note       :string
#  price      :decimal(, )      default(0.0)
#  quantity   :decimal(, )      default(0.0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  asset_id   :bigint           not null
#
# Indexes
#
#  index_transactions_on_asset_id  (asset_id)
#
# Foreign Keys
#
#  fk_rails_...  (asset_id => assets.id)
#
FactoryBot.define do
  factory :transaction do
    association :asset
    date { Faker::Date.backward(days: 30) } # 最近 30 天內的日期
    action { Transaction.actions.keys.sample } # 隨機選 buy/sell/dividend/deposit/withdraw
    quantity { Faker::Number.decimal(l_digits: 2, r_digits: 2) } # 例: 45.23
    price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }    # 例: 123.45
    amount { (quantity.to_f * price.to_f).round(2) }             # 計算總金額
    note { Faker::Lorem.sentence(word_count: 3) } # 隨機備註

    trait :buy do
      action { "buy" }
    end

    trait :sell do
      action { "sell" }
    end

    trait :dividend do
      action { "dividend" }
      quantity { 0 }
      price { 0 }
      amount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    end

    trait :deposit do
      action { "deposit" }
      quantity { 0 }
      price { 0 }
      amount { Faker::Number.decimal(l_digits: 4, r_digits: 0) } # 存款通常是整數
    end

    trait :withdraw do
      action { "withdraw" }
      quantity { 0 }
      price { 0 }
      amount { Faker::Number.decimal(l_digits: 4, r_digits: 0) }
    end
  end
end
