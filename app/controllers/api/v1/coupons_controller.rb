module Api 
    module V1 
        class CouponsController < ApiController
            
            def show
                @coupon = Coupon.find_by(code: params[:code])
                json = {discount: @coupon.promotion.discount_rate, 
                        expiration_date: I18n.l(@coupon.promotion.expiration_date)}
                render json: json, status: 200
            end

        end
    end
end

