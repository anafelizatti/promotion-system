class ProductCategoriesController < ApplicationController
  before_action :set_product_categories, only: %i[show destroy edit update]
  before_action :authenticate_user!

  def index
    @product_categories = if params[:search]
                            ProductCategory.search(params[:search])
                          else
                            ProductCategory.all
                          end
  end

  def new
    @product_categories = ProductCategory.new
  end

  def show; end

  def edit; end

  def update
    if @product_categories.update(product_categories_params)
      redirect_to product_categories_path
    else
      render :edit
    end
  end

  def destroy
    @product_categories.destroy
    redirect_to product_categories_path
  end

  def create
    @product_categories = ProductCategory.new(product_categories_params)
    if @product_categories.save
      redirect_to @product_categories
    else
      render :new
    end
  end

  private

  def set_product_categories
    @product_categories = ProductCategory.find(params[:id])
  end

  def product_categories_params
    params
      .require(:product_category)
      .permit(:name, :code, :status)
  end
end