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
require "rails_helper"

RSpec.describe Transaction, type: :model do
  let(:asset) { create(:asset, :us_stock) }

  it "has a valid factory" do
    transaction = build(:transaction, asset: asset)
    expect(transaction).to be_valid
  end

  it "is invalid without an asset" do
    transaction = build(:transaction, asset: nil)
    expect(transaction).not_to be_valid
    expect(transaction.errors[:asset]).to include("must exist")
  end

  it "is invalid without a date" do
    transaction = build(:transaction, asset: asset, date: nil)
    expect(transaction).not_to be_valid
    expect(transaction.errors[:date]).to include("can't be blank")
  end

  it "is invalid without an action" do
    transaction = build(:transaction, asset: asset, action: nil)
    expect(transaction).not_to be_valid
    expect(transaction.errors[:action]).to include("can't be blank")
  end

  it "is invalid with negative quantity" do
    transaction = build(:transaction, asset: asset, quantity: -5)
    expect(transaction).not_to be_valid
    expect(transaction.errors[:quantity]).to include("must be greater than or equal to 0")
  end

  it "is invalid with negative price" do
    transaction = build(:transaction, asset: asset, price: -10)
    expect(transaction).not_to be_valid
    expect(transaction.errors[:price]).to include("must be greater than or equal to 0")
  end

  it "is invalid with negative amount" do
    transaction = build(:transaction, asset: asset, amount: -1000)
    expect(transaction).not_to be_valid
    expect(transaction.errors[:amount]).to include("must be greater than or equal to 0")
  end

  context "with traits" do
    it "creates a buy transaction" do
      transaction = create(:transaction, :buy, asset: asset, quantity: 10, price: 100)
      expect(transaction.action).to eq("buy")
      expect(transaction.amount).to eq(1000)
    end

    it "creates a dividend transaction" do
      transaction = create(:transaction, :dividend, asset: asset, amount: 2000)
      expect(transaction.action).to eq("dividend")
      expect(transaction.quantity).to eq(0)
    end

    it "creates a deposit transaction" do
      transaction = create(:transaction, :deposit, asset: asset, amount: 5000)
      expect(transaction.action).to eq("deposit")
      expect(transaction.price).to eq(0)
    end
  end
end
