require 'rails_helper'

feature 'Admin manages category status ' do
    scenario ' and save category with status default ' do 
        user = create(:user)
        login_as user, scope: :user
    
        visit new_product_category_path
        fill_in 'Nome', with: 'Hospedagem'
        fill_in 'Código', with: 'HOSP'
        within('div#category_permission') do
            select("Allow", from: 'Autorizar para Promoção?').select_option
        end
        click_on 'Salvar categoria'
        visit product_categories_path
        click_on ('Hospedagem')
        expect(page).to have_content('Hospedagem')
        expect(page).to have_content('HOSP')
        expect(page).to have_content('Autorizar')
    end

    scenario ' and change category status ' do 
        category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        user = create(:user)
        login_as user, scope: :user
    
        visit edit_product_category_path(category)
        select("Disallow", from: "Autorizar para Promoção?").select_option
        click_on 'Salvar categoria'

        visit product_categories_path
        click_on ('Hospedagem')
        expect(page).to have_content('Hospedagem')
        expect(page).to have_content('HOSP')
        expect(page).to have_content('Não autorizar')
    end
end