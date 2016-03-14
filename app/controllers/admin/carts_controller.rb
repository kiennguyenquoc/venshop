class Admin::CartsController < ApplicationController
  before_action :authenticate_admin!
  before_action :get_all_user, only: [:index, :show]


  def show
    if params[:id] != "buyers"
      @user = User.find(params[:id])
      @carts_to_user = Cart.where(user_id: @user.id)
    else
      @carts = Cart.where(user_id: nil)
    end
  end

  def update
    @cart = Cart.find(params[:id])
    if @cart.status == "Checkout"
      status = "In process"
    else
      status = "Finish"
    end
    @cart.update(status: status)
    redirect_to admin_cart_path(id: params[:user_id])
  end

  private

  def get_all_user
    @users = User.all
  end
end
