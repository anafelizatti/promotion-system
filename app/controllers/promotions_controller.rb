class PromotionsController < ApplicationController
  before_action :set_promotion, only: %i[show edit update]

  def index
    @promotions = Promotion.all
  end

  def show;end

  def edit;end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
       redirect_to @promotion
    else
       render :new
    end
  end

  def update
    if @promotion.update(promotion_params)
      redirect_to @promotion
    else
      render :edit
    end
end

private 

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end

  def promotion_params
    params
    .require(:promotion)
    .permit(:name, :description, :code, :discount_rate, :expiration_date, :coupon_quantity)
  end

end