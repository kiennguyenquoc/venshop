class CategoriesController < ApplicationController
   before_action :find_category, only: [:show]
   before_action :check_page, only: [:show]
  def index
    @categories = Category.all
  end

  def show
    @categories = Category.all
    @current_category = @category.id
    @products = @category.products.paginate(page: params[:page]).per_page(15)
  end
  private

  def find_category
    if params[:id].to_i > (Category.count + 1)
      redirect_to error_path
    else
      @category = Category.find(params[:id])
    end
  end

end
