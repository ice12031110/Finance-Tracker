# == Schema Information
#
# Table name: stock_prices
#
#  id         :bigint           not null, primary key
#  date       :date             not null
#  price      :decimal(15, 2)   not null
#  source     :string           not null
#  ticker     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_stock_prices_on_ticker_and_date  (ticker,date) UNIQUE
#
FactoryBot.define do
  factory :stock_price do
    ticker { Faker::Finance.ticker }
    date { Date.today }
    price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    source { %w[TWSE Yahoo].sample }

    trait :twse do
      source { "TWSE" }
      ticker { "2330" }
      price { rand(400..700) }
    end

    trait :us_stock do
      source { "Yahoo" }
      ticker { "FIG" }
      price { rand(100..300) }
    end
  end
end
