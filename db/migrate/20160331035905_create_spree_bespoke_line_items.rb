class CreateSpreeBespokeLineItems < ActiveRecord::Migration
  def change
    create_table :spree_bespoke_line_items do |t|
      t.references :line_item, index: true
      t.references :option_value, index: true
      t.decimal :price_modifier, null: false, default: 0, precision: 8, scale: 2

      t.timestamps null: false
    end

    add_foreign_key :spree_bespoke_line_items, :spree_line_items, column: :line_item_id
    add_foreign_key :spree_bespoke_line_items, :spree_bespoke_option_values, column: :option_value_id
  end
end
