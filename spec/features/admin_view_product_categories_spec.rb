require 'rails_helper'

feature 'Admin view product categories' do

    scenario 'successfully' do
        ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        ProductCategory.create!(name: 'E-mail', code: 'EMAIL')

    visit root_path
    click_on 'Categorias de produto'

    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('HOSP')
    expect(page).to have_content('E-mail')
    expect(page).to have_content('EMAIL')

    end

    scenario 'and show empty message' do
        visit root_path
        click_on 'Categorias de produto'
        expect(page).to have_content('Nenhuma categoria cadastrada')
    end

    scenario 'and view details' do
        category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        visit product_categories_path

        click_on 'Hospedagem'
        expect(page).to have_content('Hospedagem')
        expect(page).to have_content('HOSP')

        click_on 'Voltar'
        expect(current_path).to eq product_categories_path

        click_on 'HOME'
        expect(current_path).to eq root_path
    end
end
