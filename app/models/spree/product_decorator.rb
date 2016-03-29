module Spree
  Product.class_eval do
    has_many :bespoke_option_types, class_name: 'Spree::Bespoke::OptionType', foreign_key: 'product_id'
  end
end
