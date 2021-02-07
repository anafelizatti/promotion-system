require 'rails_helper'

describe 'Coupon' do
  xit 'with coupons quantity available' do
    promotion = Promotion.create!(name: 'Pascoa', coupon_quantity: 3,
                                  discount_rate: 10, code: 'PASCOA10', expiration_date: 1.day.from_now)
    source_user = User.create!(id: 1, email: 'admin@locaweb.com.br', password: '123456')
    receptor_user = User.create!(id: 2, email: 'admin2@locaweb.com.br', password: '123456')
    promotion.source_user_id = source_user.id

    login_as receptor_user, scope: :user
    visit promotions_path(promotion)
    click_on 'Autorizar'

    login_as source_user, scope: :user

    visit root_path
    within 'div#body_links' do
      click_on 'Promoções'
    end
    click_on promotion.name
    expect(page).to have_current_path(promotion_path(promotion), ignore_query: true)
    click_on 'Emitir Cupons'
    expect(page).to have_content('PASCOA10-0001 (disponível)')
    expect(page).to have_content('PASCOA10-0002 (disponível)')
    expect(page).to have_content('PASCOA10-0003 (disponível)')
    expect(page).to have_content('Cupons gerados com sucesso')
    expect(page).not_to have_link('Emitir Cupons')
  end

  it 'and coupons are already generated' do
    promotion = Promotion.create!(name: 'Pascoa', coupon_quantity: 3,
                                  discount_rate: 10, code: 'PASCOA10', expiration_date: 1.day.from_now)
    coupon = promotion.coupons.create(code: 'ABCD')
    user = User.create(email: 'jane_doe@locaweb.com.br', password: '123456')
    login_as user, scope: :user

    visit promotion_path(promotion)
    expect(page).to have_content(coupon.code)
    expect(page).not_to have_link('Emitir Cupons')
  end
end
