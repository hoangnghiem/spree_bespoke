class AddBespokeFlagToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :bespoke, :boolean, default: false
  end
end
