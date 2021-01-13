require 'rails_helper'

feature 'Admin destroys a promotion' do
  
  scenario 'sucessfully' do
    promotion = Promotion.create!(name: 'Dia do consumidor', description: 'Promoção dia dos consumidores',
                      code: 'CONS10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
    login_as user, scope: :user

    visit promotions_path
    click_on promotion.name
    click_on 'Deletar'
    
    visit promotions_path
    expect(page).to_not have_content(promotion)
    expect(current_path).to eq promotions_path
  end

  scenario 'cannot delete unless logged in' do
    promotion = Promotion.create!(name: 'Dia do consumidor', description: 'Promoção dia dos consumidores',
                      code: 'CONS10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
    visit promotions_path(promotion)
    expect(page).to_not have_content(promotion)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end

end
