require 'rails_helper'

describe 'Coupon' do

    context ' when validates category' do
        it 'coupon cannot be burned unless category is present' do
            promotion = create(:promotion)
            product_category = create (:product_category)

            promotion.product_category_ids = [product_category.id]
            promotion.save!

            coupon = Coupon.create!( promotion :promotion, code: 'CONS10', status: :active)

            patch "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: 'ORDER123'} }

            expect(response).to have_http_status(401)
            expect(response.body).to include('Categoria não encontrada. Ação não pode ser realizada')

        end

        it 'coupon can be burned when category and promotion category is present' do
            promotion = create(:promotion)
            coupon = Coupon.create!( promotion :promotion, code: 'CONS10', status: :active)
            product_category = create (:product_category)

            promotion.product_category_ids = [product_category.id]
            promotion.save!

            patch "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: 'ORDER123'}, category: "HOSP" }

            expect(response).to have_http_status(200)
            expect(response.body).to include('Cupom utilizado com sucesso')
        end
    end

end