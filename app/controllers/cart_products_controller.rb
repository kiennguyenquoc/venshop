class CartProductsController < ApplicationController
  before_action :set_cart, only: [:create]
  before_action :check_quantity?, only: [:create]

  def create
    product = Product.find(params[:product_id])
    if check_quantity?
      add_product_to_cart(product.id.to_i, params[:quantity].to_i )
      respond_to do |format|
        format.html { redirect_to cart_path(id: @user_id),
        notice: 'Products add to cart' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to cart_path(id: @user_id),
        notice: 'Errors: Quantity' }
        format.json { head :no_content }
      end
    end
  end


  def destroy
    session[params[:id]].delete(params[:product_id])
    redirect_to cart_path(id: params[:id])
  end

  private

  def add_product_to_cart(product_id, number)
    number ||= 1
    i = 0
    @session[@user_id].each do |key, value|
      if (key == product_id.to_s)
       @session[@user_id][key] = number +value
       i = 1
       break
     end
    end
    if (i == 0)
      @session[@user_id][product_id] = number
    end
  end

  def check_quantity?
    if ( params[:quantity].to_i && params[:quantity].to_i > 0 )
      return true
    else false
    end
  end
end
