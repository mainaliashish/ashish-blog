class CategoriesController < ApplicationController

	before_action :set_category, only: [:edit, :update, :show, :destroy]
	before_action :require_admin, except: [:index, :show]

	def index
		@categories = Category.paginate(page: params[:page], per_page: 5)
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:info] = "Category created successfully."
			redirect_to categories_path(@categories)
		else
			render :action => 'new'
		end
	end

	def show
		@category_articles = @Category.articles.paginate(page: params[:page], per_page: 5)
	end

	private
	def set_category
		@Category = Category.find(params[:id])
	end

	def category_params
		params.require(:category).permit(:name)
	end

	def require_admin
		if !logged_in? || ( logged_in? and !current_user.admin? )
			flash[:danger] = "Only admin users can perform that action."
			redirect_to root_path
		end
	end
end