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
class Transaction < ApplicationRecord
  belongs_to :asset

  enum :action, {
    buy: "buy",
    sell: "sell",
    dividend: "dividend",
    deposit: "deposit",
    withdraw: "withdraw"
  }

  validates :date, :action, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
