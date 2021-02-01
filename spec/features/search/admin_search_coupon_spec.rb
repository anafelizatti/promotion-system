
require 'rails_helper'

feature 'Admin searchs coupons' do

    scenario  'successfully' do
        user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
        login_as user, scope: :user
        
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 2,
                                        description: 'Promoção de Cyber Monday',
                                        code: 'CYBER15', discount_rate: 15,
                                        expiration_date: '22/12/2033')
        promotion.generate_coupons! #pra gerar os cupons da promoção anterior!

        visit root_path
        within 'div#body_links' do
            click_on 'Promoções'
          end
        within('div#coupons') do
            fill_in 'search', with: 'CYBER15-0001'
            click_on 'Pesquisar'
        end

        expect(current_path).to eq search_coupons_path
        expect(page).to have_content ('CYBER15-0001 (disponível)')
        expect(page).to have_link('Cyber Monday')
        expect(page).to have_content('15.0%')
        expect(page).to have_content(22/12/2033)
        expect(page).to_not have_content('Nenhum cupom encontrado')
    end  
    
    scenario  'and can not find with inespecific code' do
        user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
        login_as user, scope: :user
        
        promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 2,
                                        description: 'Promoção de Cyber Monday',
                                        code: 'CYBER15', discount_rate: 15,
                                        expiration_date: '22/12/2033')
        promotion.generate_coupons!

        visit root_path
        within 'div#body_links' do
            click_on 'Promoções'
          end
        within('div#coupons') do
            fill_in 'search', with: 'CYBER15-001'
            click_on 'Pesquisar'
        end

        expect(current_path).to eq search_coupons_path
        expect(page).to_not have_content('CYBER15-0001')
        expect(page).to have_content('Nenhum cupom encontrado')
        expect(page).to_not have_content(promotion)
    end  

end 
