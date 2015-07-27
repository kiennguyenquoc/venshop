class CartProductsController < ApplicationController
  before_action :set_cart, only: [:create]

  def create
    product = Product.find(params[:product_id])
    @cart_product = @cart.add_product(product.id, product.price)
    respond_to do |format|
      if @cart_product.save
        format.html { redirect_to @cart_product.cart }
        format.json { render json: @cart_product,
          status: :created, location: @cart_product }
      else
        format.html { render action: "new" }
        format.json { render json: @cart_product.errors,
          status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @cart_product = CartProduct.find(params[:id])
    @cart_product.destroy
    redirect_to @cart_product.cart
  end
end
