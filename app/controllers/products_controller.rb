class ProductsController < ApplicationController

  before_action :find_product, only: [:show]
  before_action :check_page, only: [:index]

  def index
    @products = Product.paginate(page: params[:page]).per_page(15)
    @categories = Category.all
  end

  def show
    @categories = Category.all
  end

end
