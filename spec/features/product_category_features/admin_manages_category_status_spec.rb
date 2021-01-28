require 'rails_helper'

feature 'Admin manages categories status ' do
    xscenario ' and save category with status default ' do 
        category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        user = create(:user)
        login_as user, scope: :user
    
        visit product_categories_path
        expect(page).to have_content('HOSPEDAGEM')
        expect(page).to have_content('HOSP')
        expect(page).to have_content('Autorizada')
    end

    xscenario ' and change category status ' do 
        category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        user = create(:user)
        login_as user, scope: :user
    
        visit edit_product_categories_path
        select("Disallow", from: "Autorizar para promoção").select_option
        click_on 'Criar categoria'

        visit product_categories_path
    end
end