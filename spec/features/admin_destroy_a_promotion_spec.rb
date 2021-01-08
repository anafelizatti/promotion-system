require 'rails_helper'

feature 'Admin destroys a promotion' do
  
  scenario 'sucessfully' do
    promotion = Promotion.create!(name: 'Dia do consumidor', description: 'Promoção dia dos consumidores',
                      code: 'CONS10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    visit promotions_path
    click_on promotion.name
    click_on 'Deletar'
    
    visit promotions_path
    expect(page).to_not have_content(promotion)
    expect(current_path).to eq promotions_path
  end

end
