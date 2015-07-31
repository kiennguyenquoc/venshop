class ShoppingHistoryController < ApplicationController

  def index
    @user = User.find(current_user.id)
    @carts_to_user = Cart.where(user_id: @user.id)
  end

end
