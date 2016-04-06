class AddPriceModifierTypeToOptionValue < ActiveRecord::Migration
  def change
    add_column :spree_bespoke_option_values, :price_modifier_type, :string, default: 'flat_rate'
  end
end
