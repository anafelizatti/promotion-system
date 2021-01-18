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

        it 'coupon not found' do 
            get "/api/v1/coupons/ABCD123"
            expect(response).to have_http_status(:not_found)
            expect(response.body).to include('Cupom não encontrado')
        end

        #TODO fazer esse teste passar
        xit 'coupon with expired promotion' do
        end
        

    end

end


