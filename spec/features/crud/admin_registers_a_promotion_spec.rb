require 'rails_helper'

feature 'Admin registers a promotion' do
  scenario 'from index page' do
    user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
    login_as user, scope: :user

    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    expect(current_path).to eq(new_promotion_path)
  end

  scenario 'successfully' do
    user = create(:user)
    ProductCategory.create!(name:'Hospedagem', code:'HOS')
    ProductCategory.create!(name:'E-mail', code:'EMA')
    ProductCategory.create!(name:'CLOUD', code:'CLO')
    login_as user, scope: :user

    visit root_path

    click_on 'Promoções'
    click_on 'Registrar uma promoção'

    fill_in 'Nome', with: 'Cyber Monday'
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'
    check ('Hospedagem')
    check ('E-mail')
    click_on 'Salvar'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('CYBER15')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('90')
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('E-mail')
    expect(page).to_not have_content('Cloud')
    expect(page).to have_link('Voltar')
  end

  scenario 'and cannot register unless logged in from index page' do
    promotion = Promotion.create!(name: 'Dia do consumidor', description: 'Promoção dia dos consumidores',
      code: 'CONS10', discount_rate: 10, coupon_quantity: 100,
      expiration_date: '22/12/2033')

    visit new_promotion_path(promotion)
    expect(page).to_not have_content('Dia do consumidor')
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

end
