require 'rails_helper'

feature 'Admin searchs coupons' do

    xscenario  'and find coupon by code' do
        user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
        login_as user, scope: :user
        
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                        description: 'Promoção de Cyber Monday',
                                        code: 'CYBER15', discount_rate: 15,
                                        expiration_date: '22/12/2033')
        promotion.generate_coupons! #pra gerar os cupons da promoção anterior!

        visit root_path
        click_on 'Promoções'
        click_on 'Buscar Cupons'
        expect(current_path).to eq search_coupons_path

        fill_in 'search', with: 'CYBER15'
        click_on 'Pesquisar'

        expect(current_path).to eq search_coupons_path
        expect(page).to have_content('Cyber Monday')
        expect(page).to have_content('CYBER15-0001 (disponível)')
    end    
end 
