class ProductCategoriesController < ApplicationController
before_action :set_product_categories, only: %i[show]
    
    def index
        @product_categories = ProductCategory.all
    end

    def new
        @product_categories = ProductCategory.new
    end

    def show;end

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
        .permit(:name, :code)
    end

end