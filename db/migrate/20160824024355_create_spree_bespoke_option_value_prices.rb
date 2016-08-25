class CreateSpreeBespokeOptionValuePrices < ActiveRecord::Migration
  def change
    create_table :spree_bespoke_option_value_prices do |t|
      t.references :option_value, index: true
      t.string :currency
      t.decimal :amount, null: false, default: 0, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
