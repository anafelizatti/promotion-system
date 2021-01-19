require 'rails_helper'

describe 'Coupon management' do
    
    context 'show' do
        
        it 'render coupon json with discout' do 
            promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
            description: 'Promoção de Cyber Monday',
            code: 'CYBER15', discount_rate: 15,
            expiration_date: '22/12/2033')
            coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

            get "/api/v1/coupons/#{coupon.code}"

            expect(response).to have_http_status(200)
            expect(response.body).to include('15')
            expect(response.body).to include('22/12/2033')
        end

        it 'coupon not found' do 
            get "/api/v1/coupons/ABCD123"
            expect(response).to have_http_status(404)
            expect(response.body).to include('Cupom não encontrado')
        end

        #TODO fazer esse teste passar
        xit 'coupon with expired promotion' do
        end
        

    end

    context 'burn' do
        it 'change coupon status' do
            promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                        description: 'Promoção de Cyber Monday',
                                        code: 'CYBER15', discount_rate: 15,
                                        expiration_date: '22/12/2033')
            coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')
      
            post "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: 'ORDER123'} }
      
            expect(response).to have_http_status(:ok)
            expect(response.body).to include('Cupom utilizado com sucesso')
            expect(coupon.reload).to be_burn
            expect(coupon.reload.order).to eq('ORDER123')
          end
      

        xit 'coupon not found by code' do
        end

        it 'order must exist' do
            promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
            description: 'Promoção de Cyber Monday',
            code: 'CYBER15', discount_rate: 15,
            expiration_date: '22/12/2033')
            coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

            post "/api/v1/coupons/#{coupon.code}/burn", params: {}

            expect(response).to have_http_status(412)
        end
        
        it 'order and code must exist' do 
            promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                  description: 'Promoção de Cyber Monday',
                                  code: 'CYBER15', discount_rate: 15,
                                  expiration_date: '22/12/2033')
            coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

            post "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: '' } }

            expect(response).to have_http_status(422)

        end

    end

end


