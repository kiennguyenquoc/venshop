class Admin::ProductsController < ApplicationController
  require 'net/http'
  require 'uri'

  before_action :find_product, only: [:destroy, :edit,:update]
  before_action :get_categories, only: [:index, :edit,:update, :new,:create]
  before_action :authenticate_admin!
  before_action :check_page, only: [:index]

  def index
    @products = Product.paginate(page: params[:page]).per_page(50)
  end

  def destroy
    if @product.destroy
      SolrModule.new.delete_solr_index_after_delete_product(params[:id])
      flash[:success] = "Delete product : Success"
    else
      flash[:danger] = "Delete product : Error - Product add to carts"
    end
    redirect_to admin_products_path
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      SolrModule.new.create_solr_index_after_create_product(@product.id, @product.name, @product.price, @product.description)
      flash[:success] = "Create product : Success"
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      SolrModule.new.update_solr_index_after_import_product(params[:id], @product)
      flash[:success] = "Update product : Success"
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:category_id, :name, :price, :image, :description)
  end

  def get_categories
    @categories = Category.all
  end

end
