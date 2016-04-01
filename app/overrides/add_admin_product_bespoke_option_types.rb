Deface::Override.new(
  virtual_path: 'spree/admin/shared/_product_tabs',
  name: 'add_admin_product_bespoke_option_types',
  insert_bottom: '[data-hook="admin_product_tabs"]',
  partial: 'spree/admin/products/bespoke_options_menu'
)

