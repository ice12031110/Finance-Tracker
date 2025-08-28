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
FactoryBot.define do
  factory :asset_snapshot do
    association :asset
    date { Date.today }
    price { rand(50..300) }
    market_value { 0 } # 先給個 placeholder

    after(:build) do |snapshot|
      snapshot.market_value = snapshot.asset.quantity * snapshot.price if snapshot.asset
    end
  end
end
