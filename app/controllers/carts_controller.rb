class CartsController < ApplicationController
  #before_action :find_card, only: [ :create ]
  #before_action :check_phone, only: [ :create ]

  def update
  end

  def new
    @cart = Cart.new
  end

  def create
    total = 0

    @cart = Cart.new(cart_params)
    @cart.save
    if current_user
      @cart.update(user_id: current_user.id, status: "Checkout")
      user_id = current_user.id
    else
      @cart.update(user_id: "", status: "Checkout")
      user_id = 'guess'
    end
    if @cart.save
      session[user_id].each do |key, value|
        @product = Product.find(key)
        @cart_product = CartProduct.new(cart_id: @cart.id, product_id: key.to_i, number: value.to_i, price: @product.price)
        @cart_product.save
        total += @product.price * value.to_f
      end
      @cart.update( total_price: total)
      OrderNotifier.received(@cart).deliver
      respond_to do |format|
        format.html { redirect_to products_path,
        notice: 'Email to send' }
        format.json { head :no_content }
      end
     session[user_id] = nil
    else
      respond_to do |format|
        format.html { redirect_to carts_path,
        notice: 'Errors' }
        format.json { head :no_content }
      end
    end
  end

  def destroy
    session[params[:id]] = nil
    redirect_to cart_path(params[:id])
  end

  def index
    if current_user
      user_id = current_user.id
    else
      user_id = 'guess'
    end
    redirect_to cart_path(user_id)
  end



  private

  def cart_params
    params.require(:cart).permit(:full_name, :email, :address, :phone)
  end

  def find_card
    @cart = Cart.find(params[:id])
  end

  def check_phone
    params[:phone].is_a?
  end

end
