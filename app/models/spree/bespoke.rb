module Spree::Bespoke
  def self.table_name_prefix
    'spree_bespoke_'
  end

  def self.use_relative_model_naming?
    true
  end
end
