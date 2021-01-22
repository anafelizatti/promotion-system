class CouponsController <  ApplicationController

    def search
        if params[:search]
            @coupon = Coupon.find_by(code: params[:search])
        end
    end

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