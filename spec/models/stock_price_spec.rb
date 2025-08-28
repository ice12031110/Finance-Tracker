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
require "rails_helper"

RSpec.describe StockPrice, type: :model do
  it "has a valid factory" do
    expect(build(:stock_price)).to be_valid
  end

  it "is invalid without a ticker" do
    sp = build(:stock_price, ticker: nil)
    expect(sp).not_to be_valid
    expect(sp.errors[:ticker]).to include("can't be blank")
  end

  it "is invalid without a date" do
    sp = build(:stock_price, date: nil)
    expect(sp).not_to be_valid
    expect(sp.errors[:date]).to include("can't be blank")
  end

  it "is invalid without a price" do
    sp = build(:stock_price, price: nil)
    expect(sp).not_to be_valid
    expect(sp.errors[:price]).to include("can't be blank")
  end

  it "is invalid with negative price" do
    sp = build(:stock_price, price: -10)
    expect(sp).not_to be_valid
    expect(sp.errors[:price]).to include("must be greater than or equal to 0")
  end

  it "is invalid without a source" do
    sp = build(:stock_price, source: nil)
    expect(sp).not_to be_valid
    expect(sp.errors[:source]).to include("can't be blank")
  end

  it "enforces uniqueness of ticker + date" do
    create(:stock_price, ticker: "AAPL", date: Date.today)
    duplicate = build(:stock_price, ticker: "AAPL", date: Date.today)

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:ticker]).to include("has already been taken")
  end
end
