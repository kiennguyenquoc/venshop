class CategoriesController < ApplicationController
   before_action :find_category, only: [:show]
   before_action :check_page, only: [:show]
   before_action :get_all_categories, only: [:show, :index]

  def show
    @current_category = @category.id
    @products = @category.products.paginate(page: params[:page]).per_page(Settings.paginate.category)
  end

  private

  def find_category
    if params[:id].to_i > (Category.count + 1)
      redirect_to error_path
    elsif is_number?(params[:id]) == false
      redirect_to error_path
    else
      @category = Category.find(params[:id])
    end
  end

end
