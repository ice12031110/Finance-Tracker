# == Schema Information
#
# Table name: asset_snapshots
#
#  id           :bigint           not null, primary key
#  date         :date
#  market_value :decimal(, )
#  price        :decimal(, )
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  asset_id     :bigint           not null
#
# Indexes
#
#  index_asset_snapshots_on_asset_id  (asset_id)
#
# Foreign Keys
#
#  fk_rails_...  (asset_id => assets.id)
#
require 'rails_helper'

RSpec.describe AssetSnapshot, type: :model do
  let(:asset) { create(:asset, :us_stock, quantity: 10) }

  it "has a valid factory" do
    snapshot = build(:asset_snapshot, asset: asset, price: 200)
    expect(snapshot).to be_valid
  end

  it "is invalid without an asset" do
    snapshot = build(:asset_snapshot, asset: nil)
    expect(snapshot).not_to be_valid
  end

  it "calculates market value correctly" do
    snapshot = create(:asset_snapshot, asset: asset, price: 150)
    expect(snapshot.market_value).to eq(asset.quantity * 150)
  end

  it "is invalid without a date" do
    snapshot = build(:asset_snapshot, asset: asset, date: nil)
    expect(snapshot).not_to be_valid
  end
end
