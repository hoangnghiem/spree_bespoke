module Spree
  OrderContents.class_eval do

    private

    def add_to_line_item(variant, quantity, options = {})
      line_item = grab_line_item_by_variant(variant, false, options)

      if line_item
        line_item.quantity += quantity.to_i
        line_item.currency = currency unless currency.nil?
      else
        opts = { currency: order.currency }.merge ActionController::Parameters.new(options).
                                            permit(PermittedAttributes.line_item_attributes)
        line_item = order.line_items.new(quantity: quantity,
                                          variant: variant,
                                          options: opts)
      end
      line_item.target_shipment = options[:shipment] if options.has_key? :shipment
      line_item.save!

      # add bespoke options

      bespoke_option_value_ids = ( !!options[:bespoke_option_values] ? options[:bespoke_option_values] : [] )
      bespoke_option_values = bespoke_option_value_ids.map do |cid|
        Spree::Bespoke::OptionValue.find(cid) if cid.present?
      end.compact

      offset_price = 0.0
      bespoke_option_values.each do |bov|
        line_item.bespoke_line_items.create!(option_value: bov, price_modifier: bov.price_modifier)
        offset_price += bov.price_modifier
      end

      if currency
        line_item.currency = currency unless currency.nil?
        line_item.price    = variant.price_in(currency).amount + offset_price
      else
        line_item.price    = variant.price + offset_price
      end
      line_item.save!
      line_item
    end
  end
end

