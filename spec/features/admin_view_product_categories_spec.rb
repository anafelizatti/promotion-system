require 'rails_helper'

feature 'Admin view product categories' do

    scenario 'successfully' do
        ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        ProductCategory.create!(name: 'E-mail', code: 'EMAIL')
        user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
        login_as user, scope: :user

        visit root_path
        click_on 'Categorias de produto'

        expect(page).to have_content('Hospedagem')
        expect(page).to have_content('HOSP')
        expect(page).to have_content('E-mail')
        expect(page).to have_content('EMAIL')
    end

    scenario 'and show empty message' do
        user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
        login_as user, scope: :user

        visit root_path
        click_on 'Categorias de produto'
        expect(page).to have_content('Nenhuma categoria cadastrada')
    end

    scenario 'and view details' do
        category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
        login_as user, scope: :user

        visit product_categories_path

        click_on 'Hospedagem'
        expect(page).to have_content('Hospedagem')
        expect(page).to have_content('HOSP')

        click_on 'Voltar'
        expect(current_path).to eq product_categories_path

        click_on 'HOME'
        expect(current_path).to eq root_path
    end

    scenario 'and cannot view categories unless logged in' do
        visit root_path
        expect(page).to_not have_link('Categorias de produto')
    end

    scenario 'and cannot view categories unless logged in via link' do
        category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    
        visit product_categories_path
    
        expect(page).to_not have_content('Hospedagem')
        expect(page).to_not have_link('Categorias de produto')
        expect(page).to have_content('Login')
    end

    scenario 'and cannot view category details unless logged in via link' do
        category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    
        visit product_categories_path(category)

        expect(page).to_not have_content('Hospedagem')
        expect(page).to_not have_link('Editar')
        expect(page).to_not have_link('Deletar')
        expect(page).to have_content('Para continuar, efetue login ou registre-se')
    end

    scenario 'and cannot view category edit unless logged in via link' do
        category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        visit edit_product_category_path(category)
        expect(page).to have_content('Login')
    end

end
