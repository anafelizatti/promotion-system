module Api
  module V1
    class CouponsController < ApiController
      before_action :set_coupon
      before_action :verify_order_code

      def show
        if @coupon.expired?
          render json: 'Cupom fora do prazo da promoção', status: :precondition_failed
        else
          render json: @coupon, status: :ok
        end
      end

      def burn
        unless @coupon.category_is_valid? params[:category]
          return render json: 'Categoria não encontrada. Ação não pode ser realizada',
                        status: :unauthorized
        end

        @coupon.burn!(params.dig(:order, :code))
        render json: 'Cupom utilizado com sucesso', status: :ok
      rescue ActiveRecord::RecordInvalid
        render json: '', status: :unprocessable_entity
      end

      private

      def set_coupon
        @coupon = Coupon.find_by!(code: params[:code])
      rescue ActiveRecord::RecordNotFound
        render json: 'Cupom não encontrado.', status: :not_found
      end

      def verify_order_code
        return if params.fetch(:order, :code).present?

        render json: '', status: :precondition_failed
      end
    end
  end
end

