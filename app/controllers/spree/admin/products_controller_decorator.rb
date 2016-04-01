module Spree
  module Admin
    ProductsController.class_eval do
      def bespoke_options
        load_resource
        @bespoke_option_types = @product.bespoke_option_types
      end
    end
  end
end

