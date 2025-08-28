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

  validates :name, :category, :currency, presence: true
end
