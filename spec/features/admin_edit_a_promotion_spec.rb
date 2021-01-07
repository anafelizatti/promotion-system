require 'rails_helper'

feature 'Admin edits a promotion' do
  
  scenario 'sucessfully' do
    promotion = Promotion.create!(name: 'Dia do consumidor', description: 'Promoção dia dos consumidores',
                      code: 'CONS10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
    visit promotions_path
    click_on promotion.name
    click_on 'Editar'
    fill_in 'Nome', with: 'Dia do consumidor'
    fill_in 'Descrição', with: 'Promoção dia do consumidor'
    fill_in 'Código', with: 'CONSUMIDOR10'
    fill_in 'Desconto', with: '20'
    fill_in 'Quantidade de cupons', with: '200'
    fill_in 'Data de término', with: '20/12/2022'
    click_on 'Criar promoção'
    visit promotions_path
    click_on 'Dia do consumidor'
    expect(page).to have_content('Dia do consumidor')
    expect(page).to have_content('Promoção dia do consumidor')
    expect(page).to have_content('CONSUMIDOR10')
    expect(page).to have_content('20,00%')
    expect(page).to have_content('20/12/2022')
    expect(page).to have_content('200')
    expect(page).to have_link('Voltar')
  end

end