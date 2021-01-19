module Api 
    module V1 
        class CouponsController < ApiController
            def show
                @coupon = Coupon.find_by!(code: params[:code])
                render json: @coupon, status: 200

                rescue ActiveRecord::RecordNotFound
                render json: 'Cupom não encontrado', status: 404 #:not_found
            end

            def burn
                @coupon = Coupon.find_by!(code: params[:code])
                @coupon.burn!(params.require(:order).permit(:code)[:code])
                render json: 'Cupom utilizado com sucesso', status: 200
        
              rescue ActionController::ParameterMissing
                render json: '', status: :precondition_failed
              rescue ActiveRecord::RecordInvalid
                render json: '', status: 422
            end
        end
    end
 end

