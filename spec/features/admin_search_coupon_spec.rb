require 'rails_helper'

feature 'Admin searchs coupons' do

    scenario  'and find coupon by code' do
        user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
        ProductCategory.create!(name:'Hospedagem', code:'HOS')
        ProductCategory.create!(name:'E-mail', code:'EMA')
        ProductCategory.create!(name:'CLOUD', code:'CLO')
        #Promotion.create! product_category_ids:
        login_as user, scope: :user

        visit root_path

        click_on 'Promoções'
        click_on 'Registrar uma promoção'

        fill_in 'Nome', with: 'Cyber Monday'
        fill_in 'Descrição', with: 'Promoção de Cyber Monday'
        fill_in 'Código', with: 'CYBER15'
        fill_in 'Desconto', with: '15'
        fill_in 'Quantidade de cupons', with: '3'
        fill_in 'Data de término', with: '22/12/2033'
        check ('Hospedagem')
        check ('E-mail')
        click_on 'Salvar'

        visit promotions_path
        click_on 'Cyber Monday'
        click_on 'Emitir Cupons'
        expect(page).to have_content('CYBER15-0001 (disponível)')
        expect(page).to have_content('CYBER15-0002 (disponível)')
        expect(page).to have_content('CYBER15-0003 (disponível)')

        visit promotions_path
        fill_in 'search', with: 'CYBER15'
        click_on 'Pesquisar'

        expect(current_path).to eq coupons_path
        expect(page).to have_content('Cyber Monday')
        expect(page).to have_content('CYBER15-0001 (disponível)')
    end    
end 
