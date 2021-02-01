require 'rails_helper'

describe 'Coupon category management' do

    context 'validates category'
        it 'coupon cannot be burned unless category is checked' do
            promotion = create(:promotion)
            product_category = create (:product_category)

            promotion.product_category_ids = [product_category.id]
            promotion.save!

            coupon = Coupon.create!( promotion :promotion, code: 'CONS10', status: :active)

            patch "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: 'ORDER123'} }

            expect(response).to have_http_status(401)
            expect(response.body).to include('Categoria não encontrada. Ação não pode ser realizada')

        end

    end

end