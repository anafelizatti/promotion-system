class CouponsController <  ApplicationController

    def inactivate
        @coupon = Coupon.find(params[:id])
        @coupon.inactivate!
        flash[:success] = t('.sucess')
        redirect_to @coupon.promotion
    end

end