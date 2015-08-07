require 'solr'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery
  before_action :sign_out_all, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_cart
    @session = session
    if current_user
      @user_id = current_user.id
    else
      @user_id = "guess"
    end
    @session[@user_id] ||= {}
  end

  def sign_out_all
    sign_out current_user if current_user
    sign_out current_admin if current_admin
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  def check_page
    if (params[:page].to_i <= 0)
      params[:page] = 1
    end
    if is_number?(params[:page]) == false
      params[:page] = 1
    end
  end

  def is_number? string
    true if Float(string) rescue false
  end

  def find_product
    if params[:id].to_i > (Product.count + 1)
      redirect_to error_path
    elsif is_number?(params[:id]) == false
      redirect_to error_path
    else
      @product = Product.find(params[:id])
    end
  end

end
