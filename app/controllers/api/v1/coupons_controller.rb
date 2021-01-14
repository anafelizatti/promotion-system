module Api 
    module V1 
        class CouponsController < ApiController
            
            def show
                @coupon = Coupon.find_by(code: params[:code]) #acha o cupom pelo seu código de cupom, único
                #@json = @coupon.to_json #transformar em json
                json = {discount: @coupon.promotion.discount_rate, 
                        expiration_date: I18n.l(@coupon.promotion.expiration_date)}
                render json: json, status: 200 #:ok
            end

        end
    end
end

