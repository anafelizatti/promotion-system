require 'rails_helper'

feature 'Admin generates coupons' do
    scenario 'with coupons quantity available' do
        promotion = Promotion.create!(name: 'Pascoa', coupon_quantity: 3,
                                    discount_rate: 10, code:'PASCOA10', expiration_date: 1.day.from_now)
        user = User.create(email: 'jane_doe@locaweb.com.br', password: '123456')
        login_as user, scope: :user

    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    expect(current_path).to eq(promotion_path(promotion))
    click_on 'Emitir Cupons'
    expect(page).to have_content('PASCOA10-0001')
    expect(page).to have_content('PASCOA10-0002')
    expect(page).to have_content('PASCOA10-0003')
    expect(page).to have_content('Cupons gerados com sucesso')
    expect(page).to_not have_link('Emitir Cupons')

    end
end
