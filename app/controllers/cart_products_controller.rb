class CartProductsController < ApplicationController
  before_action :set_cart, only: [:create, :update]

  def create
    product = Product.find(params[:product_id])
    if check_quantity?
      add_product_to_cart(product.id.to_i, params[:quantity].to_i )
      redirect_to cart_path(id: @user_id)
      flash[:success] = 'Products add to cart'
    else
      redirect_to products_path
      flash[:danger] = 'Errors: Quantity'
    end
  end

  def update
    product = Product.find(params[:product_id])
    if check_quantity?
      update_product_to_cart(product.id.to_i, params[:quantity].to_i )
      redirect_to cart_path(id: @user_id)
      flash[:success] = 'Update successful'
    else
      redirect_to cart_path(id: @user_id)
      flash[:danger] = 'Errors: Quantity'
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
    session[@user_id].each do |key, value|
      if key == product_id.to_s
        session[@user_id][key] = number +value
        i = 1
        break
      end
    end
    session[@user_id][product_id] = number if i == 0
  end

  def update_product_to_cart(product_id, number)
    session[@user_id].each do |key, value|
      if key == product_id.to_s
        session[@user_id][key] = number
        break
     end
    end
  end

  def check_quantity?
    params[:quantity].to_i > 0 ? true : false
  end

end
