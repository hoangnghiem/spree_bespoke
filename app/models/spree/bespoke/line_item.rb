class Spree::Bespoke::LineItem < ActiveRecord::Base
  belongs_to :line_item, class_name: 'Spree::LineItem', foreign_key: 'line_item_id'
  belongs_to :option_value, class_name: 'Spree::Bespoke::OptionValue', foreign_key: 'option_value_id'
end
