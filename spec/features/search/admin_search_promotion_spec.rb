require 'rails_helper'

describe 'Admin searchs promotions' do
  it 'successfully' do
    promotion = Promotion.create!(name: 'Dia do consumidor', description: 'Promoção dia dos consumidores',
                                  code: 'CONS10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033')

    user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
    login_as user, scope: :user

    visit promotions_path
    within('div#promotion') do
      fill_in 'search', with: 'consumidor'
      click_on 'Pesquisar'
    end
    expect(page).to have_content('Dia do consumidor')
    expect(page).to have_content('Promoção dia dos consumidores')
    expect(page).to have_content('10,00%')
  end

  it 'and receive a message if not found' do
    promotion = Promotion.create!(name: 'Dia do consumidor', description: 'Promoção dia dos consumidores',
                                  code: 'CONS10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033')

    user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
    login_as user, scope: :user

    visit promotions_path
    within('div#promotion') do
      fill_in 'search', with: 'natal'
      click_on 'Pesquisar'
    end

    expect(page).to have_content('Nenhuma promoção cadastrada')
  end
end