class CreateAssetSnapshots < ActiveRecord::Migration[8.0]
  def change
    create_table :asset_snapshots do |t|
      t.references :asset, null: false, foreign_key: true
      t.date :date
      t.decimal :price
      t.decimal :market_value

      t.timestamps
    end
  end
end
