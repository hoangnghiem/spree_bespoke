class AddDescriptionToBespokeOptionValue < ActiveRecord::Migration
  def change
    add_column :spree_bespoke_option_values, :description, :text
  end
end
