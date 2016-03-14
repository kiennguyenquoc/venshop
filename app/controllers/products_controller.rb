class ProductsController < ApplicationController

  before_action :find_product, only: [:show]
  before_action :check_page, only: [:index]
  before_action :get_all_categories, only: [:index, :show]

  def index
    @products = Product.paginate(page: params[:page]).per_page(Settings.paginate.category)
  end

end
