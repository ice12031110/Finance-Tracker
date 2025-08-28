require "rails_helper"

RSpec.describe UpdateStockPricesJob, type: :job do
  describe "#perform" do
    it "calls StockPriceService.fetch_twse_all and fetch_us_all" do
      # 設定假資料
      create(:asset, ticker: "2330", category: :stock, currency: "TWD")
      create(:asset, ticker: "FIG", category: :stock, currency: "USD")

      # stub 服務呼叫
      allow(StockPriceService).to receive(:fetch_twse_all)
      allow(StockPriceService).to receive(:fetch_us_all)

      described_class.perform_now

      expect(StockPriceService).to have_received(:fetch_twse_all).once
      expect(StockPriceService).to have_received(:fetch_us_all).once
    end
  end
end
