class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @current_category = @category.id
    @products = @category.products.paginate(page: params[:page]).per_page(15)
  end

end
