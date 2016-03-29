class CreateSpreeBespokeOptionValues < ActiveRecord::Migration
  def change
    create_table :spree_bespoke_option_values do |t|
      t.references :option_type, index: true
      t.string :name
      t.attachment :image
      t.decimal :price_modifier, null: false, default: 0, precision: 8, scale: 2
      t.integer :position

      t.timestamps null: false
    end

    add_foreign_key :spree_bespoke_option_values, :spree_bespoke_option_types, column: :option_type_id
  end
end
