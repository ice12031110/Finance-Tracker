class CreateStockPrices < ActiveRecord::Migration[8.0]
  def change
    create_table :stock_prices do |t|
      t.string :ticker, null: false
      t.date   :date, null: false
      t.decimal :price, precision: 15, scale: 2, null: false
      t.string :source, null: false
      t.timestamps
    end

    add_index :stock_prices, [ :ticker, :date ], unique: true
  end
end
