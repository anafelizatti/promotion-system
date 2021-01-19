require 'rails_helper'

feature 'Admin searchs items' do
  
    scenario 'in promotions' do
        promotion = Promotion.create!(name: 'Dia do consumidor', description: 'Promoção dia dos consumidores',
                        code: 'CONS10', discount_rate: 10, coupon_quantity: 100,
                        expiration_date: '22/12/2033')
                        
        user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
        login_as user, scope: :user

        visit promotions_path
        fill_in 'search', with: 'consumidor'
        click_on 'Pesquisar'
        expect(page).to have_content('Dia do consumidor')
        expect(page).to have_content('Promoção dia dos consumidores')
        expect(page).to have_content('10,00%')
    end

    scenario 'in promotions and receive a message if not found' do
        promotion = Promotion.create!(name: 'Dia do consumidor', description: 'Promoção dia dos consumidores',
                        code: 'CONS10', discount_rate: 10, coupon_quantity: 100,
                        expiration_date: '22/12/2033')
                        
        user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
        login_as user, scope: :user

        visit promotions_path
        fill_in 'search', with: 'natal'
        click_on 'Pesquisar'
        expect(page).to have_content('Nenhuma promoção cadastrada')
    end

    scenario 'in product categories' do

        category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
        login_as user, scope: :user

        visit product_categories_path
        fill_in 'search', with: 'hosp'
        click_on 'Pesquisar'

        expect(page).to have_content('Hospedagem')
        expect(page).to have_content('HOSP')
    end

    scenario 'in product categories and receive a message if not found' do

        category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
        login_as user, scope: :user
        
        visit product_categories_path
        fill_in 'search', with: 'LOREMIPSUM'
        click_on 'Pesquisar'
        
        expect(page).to have_content('Nenhuma categoria cadastrada')
    end
        
end