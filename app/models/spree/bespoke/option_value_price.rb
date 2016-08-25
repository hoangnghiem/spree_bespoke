class Spree::Bespoke::OptionValuePrice < Spree::Base
  belongs_to :option_value, class_name: 'Spree::Bespoke::OptionValue', foreign_key: 'option_value_id', touch: true, inverse_of: :prices

  validate :check_price

  validates :amount, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validate :validate_amount_maximum

  extend Spree::DisplayMoney
  money_methods :amount, :price

  self.whitelisted_ransackable_attributes = ['amount']

  def money
    Spree::Money.new(amount || 0, { currency: currency })
  end

  def price
    amount
  end

  def price=(price)
    self[:amount] = Spree::LocalizedNumber.parse(price)
  end

  # Remove variant default_scope `deleted_at: nil`
  def option_value
    Spree::Bespoke::OptionValue.unscoped { super }
  end

  private

  def check_price
    self.currency ||= Spree::Config[:currency]
  end

  def maximum_amount
    BigDecimal '999999.99'
  end

  def validate_amount_maximum
    if amount && amount > maximum_amount
      errors.add :amount, I18n.t('errors.messages.less_than_or_equal_to', count: maximum_amount)
    end
  end

end
