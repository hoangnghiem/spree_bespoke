class Spree::Admin::BespokeOptionTypesController < Spree::Admin::BaseController 
  before_action :load_product

  def create
    @bespoke_option_type = @product.bespoke_option_types.build(option_type_params)
    
    if @bespoke_option_type.save
      redirect_to bespoke_options_admin_product_path(@product), notice: 'Bespoke option type created'
    else
      redirect_to bespoke_options_admin_product_path(@product), alert: @bespoke_option_type.errors.full_messages
    end
  end

  def edit
    @bespoke_option_type = @product.bespoke_option_types.find(params[:id])
  end

  def update
    @bespoke_option_type = @product.bespoke_option_types.find(params[:id])

    if @bespoke_option_type.update_attributes(option_type_params)
      redirect_to edit_admin_product_bespoke_option_type_path(@product, @bespoke_option_type), notice: 'Bespoke option type updated'
    else
      render :edit
    end
  end

  def destroy
    @bespoke_option_type = @product.bespoke_option_types.find(params[:id])
    @bespoke_option_type.destroy

    respond_with(@bespoke_option_type) do |format|
      format.html { redirect_to bespoke_options_admin_product_path(@product), notice: 'Bespoke Option Type deleted' }
      format.js   { render :partial => "spree/admin/shared/destroy" }
    end
  end

  private

  def load_product
    @product = Spree::Product.friendly.find(params[:product_id])
  end

  def option_type_params
    params.require(:option_type).permit!
  end

end
