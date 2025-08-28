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
class Asset < ApplicationRecord
  enum :category, { stock: 0, cash: 1, crypto: 2 }
  has_many :asset_snapshots, dependent: :destroy

  validates :name, :category, :quantity, :currency, :ticker, presence: true

  after_create :ensure_stock_price_data

  private

  def ensure_stock_price_data
    return if cash? || crypto?

    today = Date.today

    # Step 1: 檢查是否已有 StockPrice
    existing = StockPrice.find_by(ticker: ticker, date: today)
    return if existing.present?

    # Step 2: 嘗試抓行情
    if ticker.match?(/^\d{4}$/) # 台股
      StockPriceService.fetch_twse_all
    else # 美股 / 其他
      StockPriceService.fetch_us(ticker)
    end

    # Step 3: 再檢查一次，有沒有拿到行情
    existing = StockPrice.find_by(ticker: ticker, date: today)
    return if existing.present?

    # Step 4: 還是沒有 → 當作 Other 市場 (自定義資產)
    StockPrice.create!(
      ticker: ticker,
      date: today,
      price: 0,
      source: "Other"
    )
  end
end
