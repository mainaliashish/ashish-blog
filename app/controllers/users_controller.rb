class UsersController < ApplicationController

	before_action :set_user, only: [:edit, :update, :show, :destroy]
	before_action :require_user, only: [:edit, :update, :destroy]
	before_action :require_same_user, only: [:edit, :update]
	before_action :require_admin, only: [:destroy]

	def index
	@users = User.paginate(page: params[:page], per_page: 5)
	end

	def new
	@user = User.new
	render 'users/new'
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:info] = "Welcome to Weblog #{@user.username}"
			redirect_to user_path(@user)
		else
			render :action => 'new'
			#redirect_to new_user_path(@user)
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
		flash[:info] = "User Was Updated Successfully!"
		redirect_to articles_path
		else
			render 'edit'
		end
	end

	def show
		@user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end

	def destroy
		@user.destroy
		flash[:danger] = "User and all articles created by user have been deleted."
		redirect_to users_path
	end

	private
	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def require_same_user
		if current_user != @user and !current_user.admin?
			flash[:danger] = "You can only edit your own account."
			redirect_to root_path
		end
	end

	def require_admin
		if logged_in? && !current_user.admin?
			flash[:danger] = "Only admin users can perform that action."
			redirect_to root_path
		end
	end
end