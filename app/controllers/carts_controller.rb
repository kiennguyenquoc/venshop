class CartsController < ApplicationController
  before_action :find_card, only: [ :update ]
  def show
    @cart = Cart.find(session[:cart_id])
    total_price = @cart.total_price
    @cart.update(total_price: total_price)
  end

  def edit
     @cart = Cart.find(session[:cart_id])
  end

  def update
    @cart = Cart.find(session[:cart_id])
    @user = User.find(@cart.user_id)
    @user.update(address: params['cart']['address'], phone: params['cart']['phone'])
    @cart.update(cart_params)
    @cart.update(status: "checkout")
    OrderNotifier.received(@cart).deliver
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to products_path,
      notice: 'Email to send' }
      format.json { head :no_content }
    end
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to products_path,
      notice: 'Your cart is currently empty' }
      format.json { head :no_content }
    end
  end

  private
  def cart_params
    params.require(:cart).permit(:full_name, :email, :address, :phone)
  end

  def find_card
    @cart = Cart.find(params[:id])
  end

  def add_product_to_cart(product_id, quantity)
    quantity ||= 1
    product_id = product_id.to_s

    current_quantity = cart_products_hash.fetch(product_id, {}).fetch('quantity', 0)
    quantity += current_quantity

    cart_products_hash[product_id] = { 'quantity' => quantity }
  end

  def remove_product_from_cart(product_id)
    product_id = product_id.to_s
    cart_products_hash.delete(product_id)
  end

   def cart_hash
    @session['cart']
  end

  def cart_products_hash
    @session['cart']['products']
  end

end
