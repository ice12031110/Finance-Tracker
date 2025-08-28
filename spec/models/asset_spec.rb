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
require 'rails_helper'

RSpec.describe Asset, type: :model do
  it "has valid factory" do
    expect(build(:asset)).to be_valid
  end

  it "is invalid without name" do
    asset = build(:asset, name: nil)
    expect(asset).not_to be_valid
  end

  it "supports enum categories" do
    expect(Asset.categories.keys).to include("stock", "cash", "crypto")
  end
end
