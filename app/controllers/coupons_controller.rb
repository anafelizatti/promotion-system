class CouponsController <  ApplicationController

    def inactivate
        @coupon = Coupon.find(params[:id])
        @coupon.inactivate!
        flash[:success] = t('.sucess')
        redirect_to @coupon.promotion
    end

    def active
        @coupon = Coupon.find(params[:id])
        @coupon.active!
        flash[:success] = t('.sucess')
        redirect_to @coupon.promotion
    end


end