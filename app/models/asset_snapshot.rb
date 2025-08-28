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
class AssetSnapshot < ApplicationRecord
  belongs_to :asset
  
  validates :date, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :market_value, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
