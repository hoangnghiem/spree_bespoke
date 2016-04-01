Deface::Override.new(:virtual_path => 'spree/admin/products/_form',
  :name => 'add_bespoke_to_product_edit',
  :insert_after => "[data-hook='admin_product_form_slug']",
  :text => "
    <%= f.field_container :bespoke, class: ['form-group'] do %>
      <%= f.label :bespoke, 'Bespoke' %>
      <%= f.error_message_on :bespoke %>
      <%= f.check_box :bespoke, class: 'form-control' %>
    <% end %>
  ")

