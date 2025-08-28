class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :asset, null: false, foreign_key: true
      t.date :date, null: false
      t.string :action, null: false
      t.decimal :quantity, default: 0
      t.decimal :price, default: 0
      t.decimal :amount, default: 0
      t.string :note

      t.timestamps
    end
  end
end
