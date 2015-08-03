class Admin::ProductsController < ApplicationController
  before_action :find_product, only: [:destroy, :edit,:update]
  before_action :authenticate_admin!

  def index
    @products = Product.paginate(page: params[:page]).per_page(50)
    @categories = Category.all
  end

  def destroy
    if @product.destroy
      flash[:success] = "Delete product : Success"
    else
      flash[:danger] = "Delete product : Error - Product add to carts"
    end
    redirect_to admin_products_path
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Create product : Success"
      redirect_to admin_products_path
    else
      flash[:danger] = "Error: New product"
      redirect_to new_admin_product_path
    end
  end

  def update
    if @product.update(product_params)
      flash[:success] = "Update product : Success"
      redirect_to admin_products_path
    else
      flash[:danger] = "Error: Update product"
      redirect_to edit_admin_product_path(id: params[:id])
    end
  end

  private

  def find_product
   @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:category_id, :name, :price, :image, :description)
  end
end
