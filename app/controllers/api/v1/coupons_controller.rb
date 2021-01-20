module Api 
    module V1 
        class CouponsController < ApiController
            before_action :verify_order_code, only: %i[burn]

            def show
                @coupon = Coupon.find_by!(code: params[:code])
                render json: @coupon, status: 200

                rescue ActiveRecord::RecordNotFound
                render json: 'Cupom não encontrado', status: 404 #:not_found
            end

            def burn
                @coupon = Coupon.find_by!(code: params[:code])
                @coupon.burn!(params.dig(:order, :code))
                render json: 'Cupom utilizado com sucesso', status: 200
               
              rescue ActiveRecord::RecordInvalid
                render json: '', status: 422
            end

            private
            
            def verify_order_code
                return if params.fetch(:order, :code).present?
                render json: '', status: :precondition_failed
            end

        end
    end
 end

