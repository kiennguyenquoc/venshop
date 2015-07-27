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
    #@user = User.find(@cart.user_id)
    @cart.update(cart_params)
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
end
