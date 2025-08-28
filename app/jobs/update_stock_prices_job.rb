class UpdateStockPricesJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "[UpdateStockPricesJob] 開始更新每日股票收盤價..."

    # 台股：抓所有
    StockPriceService.fetch_twse_all

    # 美股：抓資產表裡有的 ticker
    StockPriceService.fetch_us_all

    Rails.logger.info "[UpdateStockPricesJob] 完成每日股票收盤價更新"
  end
end
