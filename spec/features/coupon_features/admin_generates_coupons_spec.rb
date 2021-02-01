require 'rails_helper'

feature 'Admin generates coupons' do
    scenario 'with coupons quantity available' do
        promotion = Promotion.create!(name: 'Pascoa', coupon_quantity: 3,
                                    discount_rate: 10, code:'PASCOA10', expiration_date: 1.day.from_now)
        user = User.create(email: 'jane_doe@locaweb.com.br', password: '123456')
        login_as user, scope: :user

    visit root_path
        within 'div#body_links' do
            click_on 'Promoções'
        end
    click_on promotion.name
    expect(current_path).to eq(promotion_path(promotion))
    click_on 'Emitir Cupons'
    expect(page).to have_content('PASCOA10-0001 (disponível)')
    expect(page).to have_content('PASCOA10-0002 (disponível)')
    expect(page).to have_content('PASCOA10-0003 (disponível)')
    expect(page).to have_content('Cupons gerados com sucesso')
    expect(page).to_not have_link('Emitir Cupons')
    end

    scenario 'and coupons are already generated' do
        promotion = Promotion.create!(name: 'Pascoa', coupon_quantity: 3,
                                    discount_rate: 10, code:'PASCOA10', expiration_date: 1.day.from_now)
        coupon = promotion.coupons.create(code: 'ABCD')
        user = User.create(email: 'jane_doe@locaweb.com.br', password: '123456')
        login_as user, scope: :user

    visit promotion_path(promotion)
    expect(page).to have_content(coupon.code)
    expect(page).to_not have_link('Emitir Cupons')
    end
end
