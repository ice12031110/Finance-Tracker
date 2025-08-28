require "net/http"
require "json"

class StockPriceService
  ALPHA_VANTAGE_URL = "https://www.alphavantage.co/query"

  class << self
    # 台股：抓取當日全部股票
    def fetch_twse_all
      url = URI("https://openapi.twse.com.tw/v1/exchangeReport/STOCK_DAY_ALL")
      res = Net::HTTP.get(url)
      data = JSON.parse(res)

      data.each do |row|
        ticker = row["Code"]
        price  = row["ClosingPrice"].to_f
        next if price.zero?

        StockPrice.find_or_create_by!(ticker: ticker, date: Date.today) do |sp|
          sp.price  = price
          sp.source = "TWSE"
        end
      end
    end

    # 美股：抓特定代號
    def fetch_us(ticker)
      api_key = ENV["ALPHAVANTAGE_KEY"]
      url = URI("#{ALPHA_VANTAGE_URL}?function=GLOBAL_QUOTE&symbol=#{ticker}&apikey=#{api_key}")

      res = Net::HTTP.get(url)

      begin
        json = JSON.parse(res)
      rescue JSON::ParserError
        Rails.logger.error("[StockPriceService] Alpha Vantage API error for #{ticker}: #{res[0..100]}")
        return nil
      end

      price = json.dig("Global Quote", "05. price")&.to_f
      return unless price && price > 0

      StockPrice.find_or_create_by!(ticker: ticker, date: Date.today) do |sp|
        sp.price  = price
        sp.source = "AlphaVantage"
      end
    end

    # 美股：批量抓取（依 Asset 中有的 ticker）
    def self.fetch_us_all
      Asset.distinct.pluck(:ticker).each do |ticker|
        next if ticker.match?(/^\d{4}$/) # 台股略過
        fetch_us(ticker)
        sleep 12 # Alpha Vantage 免費版每分鐘最多 5 次，這樣比較安全
      end
    end
  end
end
