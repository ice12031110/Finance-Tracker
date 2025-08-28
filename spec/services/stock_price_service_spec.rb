require "rails_helper"

RSpec.describe StockPriceService do
  describe ".fetch_twse_all" do
    it "creates stock prices for TWSE tickers" do
      stubbed_response = [
        { "Code" => "2330", "ClosingPrice" => "600.0" },
        { "Code" => "2317", "ClosingPrice" => "100.0" }
      ].to_json

      allow(Net::HTTP).to receive(:get).and_return(stubbed_response)

      expect {
        described_class.fetch_twse_all
      }.to change { StockPrice.count }.by(2)

      sp = StockPrice.find_by(ticker: "2330")
      expect(sp.price).to eq(600.0)
      expect(sp.source).to eq("TWSE")
    end

    it "skips invalid price rows" do
      stubbed_response = [
        { "Code" => "9999", "ClosingPrice" => "0" }
      ].to_json
      allow(Net::HTTP).to receive(:get).and_return(stubbed_response)

      expect {
        described_class.fetch_twse_all
      }.not_to change { StockPrice.count }
    end
  end

  describe ".fetch_us" do
    it "creates stock price for FIG" do
      ticker = "FIG"
      stubbed_response = {
        "Global Quote" => {
          "01. symbol" => "FIG",
          "05. price" => "520.5"
        }
      }.to_json

      allow(Net::HTTP).to receive(:get).and_return(stubbed_response)

      expect {
        described_class.fetch_us(ticker)
      }.to change { StockPrice.count }.by(1)

      sp = StockPrice.find_by(ticker: "FIG")
      expect(sp.price).to eq(520.5)
      expect(sp.source).to eq("AlphaVantage")
    end
  end
end
