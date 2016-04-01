class Spree::Admin::BespokeOptionValuesController < Spree::Admin::BaseController 
  before_action :load_product
  before_action :load_option_type

  def new
    @bespoke_option_value = @bespoke_option_type.option_values.build
  end

  def create
    @bespoke_option_value = @bespoke_option_type.option_values.build(option_params)

    if @bespoke_option_value.save
      redirect_to edit_admin_product_bespoke_option_type_path(@product, @bespoke_option_type), notice: 'Bespoke Option Value created'
    else
      render :new
    end
  end

  def edit
    @bespoke_option_value = @bespoke_option_type.option_values.find(params[:id])
  end

  def update
    @bespoke_option_value = @bespoke_option_type.option_values.find(params[:id])

    if @bespoke_option_value.update_attributes(option_params)
      redirect_to edit_admin_product_bespoke_option_type_path(@product, @bespoke_option_type), notice: 'Bespoke Option Value updated'
    else
      render :edit
    end
  end

  def destroy
    @bespoke_option_value = @bespoke_option_type.option_values.find(params[:id])
    @bespoke_option_value.destroy

    respond_with(@bespoke_option_value) do |format|
      format.html { redirect_to edit_admin_product_bespoke_option_type_path(@product, @bespoke_option_type), notice: 'Bespoke Option Value deleted' }
      format.js   { render :partial => "spree/admin/shared/destroy" }
    end
  end

  private

  def load_product
    @product = Spree::Product.friendly.find(params[:product_id])
  end

  def load_option_type
    @bespoke_option_type = @product.bespoke_option_types.find(params[:bespoke_option_type_id])
  end

  def option_params
    params.require(:option_value).permit!
  end

end

