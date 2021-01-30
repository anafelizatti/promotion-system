require 'rails_helper'

feature 'Admin manages promotions authorization' do

    xscenario 'and only generates coupons if category status is allowed' do
        user = create(:user)
        login_as user, scope: :user
        category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        category.allow!
        visit new_promotion_path

        fill_in 'Nome', with: 'Cyber Monday'
        fill_in 'Descrição', with: 'Promoção de Cyber Monday'
        fill_in 'Código', with: 'CYBER15'
        fill_in 'Desconto', with: '15'
        fill_in 'Quantidade de cupons', with: '90'
        fill_in 'Data de término', with: '22/12/2033'
        check ('Hospedagem')
        click_on 'Salvar'
        visit promotions_path
        click_on 'Cyber Monday'
        expect(page).to have_link('Emitir Cupons')
    end

    scenario 'and can not generates coupons if category status is disallowed' do
        user = create(:user)
        login_as user, scope: :user
        category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
        category.disallow!
        visit new_promotion_path

        fill_in 'Nome', with: 'Cyber Monday'
        fill_in 'Descrição', with: 'Promoção de Cyber Monday'
        fill_in 'Código', with: 'CYBER15'
        fill_in 'Desconto', with: '15'
        fill_in 'Quantidade de cupons', with: '90'
        fill_in 'Data de término', with: '22/12/2033'
        check ('Hospedagem')
        click_on 'Salvar'
        visit promotions_path
        click_on 'Cyber Monday'
        expect(page).to_not have_link('Emitir Cupons')
    end

end
