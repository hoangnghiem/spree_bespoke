class Spree::Bespoke::OptionValue < Spree::Base
  belongs_to :option_type, class_name: 'Spree::Bespoke::OptionType', foreign_key: 'option_type_id'
  acts_as_list scope: :option_type

  has_many :prices, class_name: 'Spree::Bespoke::OptionValuePrice', dependent: :destroy, inverse_of: :option_value
  accepts_nested_attributes_for :prices

  Paperclip.interpolates :option_type_id do |attachment, style|
    attachment.instance.option_type.id
  end

  has_attached_file :image,
                    url: '/spree/bespoke/option_type/:option_type_id/option_value/:id/:basename.:extension',
                    path: ':rails_root/public/spree/bespoke/option_type/:option_type_id/option_value/:id/:basename.:extension'

  validates_attachment :image, :content_type => { :content_type => %w(image/jpeg image/jpg image/png image/gif) }

  validates :name, presence: true
  
  def price_in(currency)
    prices.detect { |price| price.currency == currency } || Spree::Bespoke::OptionValuePrice.new(option_value_id: id, currency: currency)
  end

  def amount_in(currency)
    price_in(currency).try(:amount)
  end

end
