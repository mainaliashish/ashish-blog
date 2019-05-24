class CategoriesController < ApplicationController

	before_action :set_category, only: [:edit, :update, :show, :destroy]

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
	end

	private
	def set_category
		@Category = Category.find(params[:id])
	end

	def category_params
		params.require(:category).permit(:name)
	end

end