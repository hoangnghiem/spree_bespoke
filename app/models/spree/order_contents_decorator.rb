module Spree
  OrderContents.class_eval do

    private

    def add_to_line_item(variant, quantity, options = {})
      puts "======================================"
      puts "add_to_line_item"
      puts "options = #{options}"
      puts "order.currency = #{order.currency}"
      puts "currency = #{currency}"
      puts "======================================"

      line_item = grab_line_item_by_variant(variant, false, options)

      if line_item
        puts "cong don qty"
        line_item.quantity += quantity.to_i
        line_item.currency = currency unless currency.nil?
      else
        opts = { currency: order.currency }.merge ActionController::Parameters.new(options).
                                            permit(PermittedAttributes.line_item_attributes)
        puts "tao moi line item"
        puts opts
        line_item = order.line_items.new(quantity: quantity,
                                          variant: variant,
                                          options: opts)
      end
      line_item.target_shipment = options[:shipment] if options.has_key? :shipment
      line_item.save!

      # add bespoke options if bespoke product
      if variant.product.bespoke
        offset_price = 0.0

        bespoke_option_value_ids = ( !!options[:bespoke_option_values] ? options[:bespoke_option_values] : [] )
        bespoke_option_values = bespoke_option_value_ids.map do |cid|
          Spree::Bespoke::OptionValue.find(cid) if cid.present?
        end.compact

        bespoke_option_values.select {|bo| bo.price_modifier_type == 'flat_rate'}.each do |bov|
          line_item.bespoke_line_items.create!(option_value: bov, price_modifier: bov.amount_in(order.currency))
          offset_price += bov.amount_in(order.currency)
        end

        bespoke_option_values.select {|bo| bo.price_modifier_type == 'percentage'}.each do |bov|
          amount = ((bov.amount_in(order.currency)/ 100.0) * offset_price).round(2)
          line_item.bespoke_line_items.create!(option_value: bov, price_modifier: bov.amount_in(order.currency))
          offset_price += amount
        end

        line_item.price = (variant.price_in(order.currency).amount || variant.price) + offset_price
        line_item.save!
      end

      line_item
    end
  end
end

