class SearchController < ApplicationController

  def search
    if params[:keyword].nil?
      @products = []
    else
      @products = Product.search(params[:keyword]).paginate(page: params[:page]).per_page(18)
    end
  end
end
