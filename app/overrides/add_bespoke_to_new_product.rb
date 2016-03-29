Deface::Override.new(:virtual_path => "spree/admin/products/new",
                     :name => "new_product_bespoke_flag",
                     :insert_after => "[data-hook='new_product_shipping_category']",
                     :original => '3e6211b0768657d8df2be7da9ede942fbb4277dd',
                     :partial => "spree/admin/products/bespoke_field")
