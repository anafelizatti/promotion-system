require 'rails_helper'

feature 'Admin registers a valid promotion' do
  scenario 'and attributes cannot be blank' do

    user = create(:user)
    login_as user, scope: :user

    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    click_on 'Salvar'

    expect(page).to have_content('não pode ficar em branco', count: 5)
  end

  scenario 'and code must be unique' do
    
    user = create(:user)
    login_as user, scope: :user

    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    fill_in 'Código', with: 'NATAL10'
    click_on 'Salvar'

    expect(page).to have_content('já está em uso')
  end

  scenario 'and coupon quantity must be greater than 0' do
    user = create(:user)
    login_as user, scope: :user

    visit promotions_path
    click_on 'Registrar uma promoção'

    fill_in 'Nome', with: 'Cyber Monday'
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '0'
    fill_in 'Data de término', with: '22/12/2033'
    click_on 'Salvar'

    expect(page).to have_content('Quantidade de cupons Deve ser maior que 0')
  end

end

