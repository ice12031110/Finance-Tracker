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
class StockPrice < ApplicationRecord
  validates :ticker, :date, :price, :source, presence: true
  validates :ticker, uniqueness: { scope: :date }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
