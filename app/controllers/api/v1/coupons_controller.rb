module Api 
    module V1 
        class CouponsController < ApiController
            def show
                @coupon = Coupon.find_by!(code: params[:code])
                json = {discount: @coupon.promotion.discount_rate, 
                        expiration_date: I18n.l(@coupon.promotion.expiration_date)}
                render json: json, status: 200

                rescue ActiveRecord::RecordNotFound
                render json: 'Cupom não encontrado', status: :not_found
            end

            def burn
                @coupon = Coupon.find_by!(code: params[:code])
                @coupon.order = params.require(:order).permit(:code)
                @coupon.burn!
                render json: 'Cupom utilizado com sucesso', status: :ok
            rescue ActionController::ParameterMissing
                render json: '', status: :precondition_failed
            end
        end
    end
 end

