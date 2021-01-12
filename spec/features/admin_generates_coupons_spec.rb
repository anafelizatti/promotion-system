require 'rails_helper'

feature 'Admin generates coupons' do
    xscenario 'with coupons quantity available' do
        promotion = Promotion.create!(name: 'Pascoa', coupon_quantity: 3,
                                    discount_rate: 10, code:'PASCOA10', expiration_date: 1.day.from_now)
    user = User.create(email: 'jane_doe@locaweb.com.br', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    clik_on promotion.name
    click_on 'Emitir Cupons'
    
    expect(current_path).to eq(promotions_path(promotion))
    expect(page).to have_content('PASCOA10-001')
    expect(page).to have_content('PASCOA10-002')
    expect(page).to have_content('PASCOA10-003')
    expect(page).to have_content('Os cupons foram gerados com sucesso!')
    expect(page).to_not have_link('Emitir cupons')

    end
end
