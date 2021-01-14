require 'rails_helper'

describe 'Coupon management' do
    
    context 'show' do
        
        it 'render coupon json with discout' do 
            promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
            description: 'Promoção de Cyber Monday',
            code: 'CYBER15', discount_rate: 15,
            expiration_date: '22/12/2033')
            coupon = Coupon.create!(promotion: promotion, code: 'CYBER-0001')

            get "/api/v1/coupons/#{coupon.code}"

            expect(response).to have_http_status(200)
            expect(response.body).to include('15')
            expect(response.body).to include('22/12/2033')
        end

    end

end


