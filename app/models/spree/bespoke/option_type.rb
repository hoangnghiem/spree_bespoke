class Spree::Bespoke::OptionType < ActiveRecord::Base
  belongs_to :product, class_name: 'Spree::Product', foreign_key: 'product_id'
  has_many :option_values, class_name: 'Spree::Bespoke::OptionValue', foreign_key: 'option_type_id', dependent: :destroy
  acts_as_list scope: :product
  validates :name, presence: true
end
