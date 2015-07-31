class CartsController < ApplicationController
  #before_action :find_card, only: [ :create ]

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
      update_info_user()
      OrderNotifier.received(@cart).deliver
      session[user_id] = nil
      flash[:success] = "Email to send"
      redirect_to products_path
    else
      flash[:danger] = "Error"
      redirect_to carts_path
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

  def update_info_user
    if user_signed_in?
      user = User.find(current_user.id)
      if user.phone == nil
        user.update(phone: params[:cart][:phone])
      end
      if user.address == nil
        user.update(address: params[:cart][:address])
      end
    end
  end

end
