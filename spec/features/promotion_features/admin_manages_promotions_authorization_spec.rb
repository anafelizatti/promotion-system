require 'rails_helper'

feature 'Admin manages promotions authorization' do

    xscenario 'and only generates coupons if category status is allowed' do
        user = create(:user)
        login_as user, scope: :user
        promotion = create (:promotion)
        category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        visit promotions_path(promotion)
        expect(page).to have_link('Emitir Cupons')
    end

    xscenario 'and can not generates coupons if category status is allowed' do
        user = create(:user)
        login_as user, scope: :user
        promotion = create (:promotion)
        category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        visit promotions_path(promotion)
        expect(page).to_not have_link('Emitir Cupons')
        expect(page).to have_content('Categoria não permitida para gerar cupons de promoção')
        expect(page).to have_link('Ver Categorias')
    end


end
