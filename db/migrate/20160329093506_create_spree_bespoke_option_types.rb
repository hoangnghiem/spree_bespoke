class CreateSpreeBespokeOptionTypes < ActiveRecord::Migration
  def change
    create_table :spree_bespoke_option_types do |t|
      t.references :product, index: true
      t.string :name
      t.integer :position

      t.timestamps null: false
    end

    add_foreign_key :spree_bespoke_option_types, :spree_products, column: :product_id
  end
end
