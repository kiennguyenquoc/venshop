class ProductsController < ApplicationController
  before_action :find_product, only: [:show]

  def index
    @products = Product.paginate(page: params[:page]).per_page(21)
    @categories = Category.all
  end

  def show
    @categories = Category.all
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

end
