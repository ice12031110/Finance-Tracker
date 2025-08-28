class CreateAssets < ActiveRecord::Migration[8.0]
  def change
    create_table :assets do |t|
      t.string :name
      t.integer :category
      t.string :ticker
      t.decimal :quantity
      t.decimal :avg_cost
      t.string :currency

      t.timestamps
    end
  end
end
