class Admin::UsersController < ApplicationController
	before_action :authenticate_admin!
	
	def index
		@users = User.paginate(page: params[:page]).per_page(21)
	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
      flash[:success] = "Delete User : Success"
    else
      flash[:danger] = "Delete User : Error"
    end
    redirect_to admin_users_path
	end
end
