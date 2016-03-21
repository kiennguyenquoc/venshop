class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :check_page, only: [:index]

  def index
    @users = User.paginate(page: params[:page]).per_page(15)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy ? flash[:success] = "Delete User : Success" : flash[:danger] = "Delete User : Error"
    redirect_to admin_users_path
  end
end
