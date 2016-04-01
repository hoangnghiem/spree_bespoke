module Spree
  LineItem.class_eval do
    has_many :bespoke_line_items, class_name: 'Spree::Bespoke::LineItem', foreign_key: 'line_item_id', dependent: :destroy
    has_many :bespoke_option_values, through: :bespoke_line_items, source: :option_value

    def bespoke_options_text
      values = self.bespoke_option_values.sort do |a, b|
        a.option_type.position <=> b.option_type.position
      end

      values.to_a.map! do |ov|
        "#{ov.option_type.name}: #{ov.name}"
      end

      values.to_sentence({ words_connector: ", ", two_words_connector: ", " })
    end
  end
end
