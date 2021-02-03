require 'rails_helper'

describe 'Promotion' do
  it 'successfully' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')

    user = create(:user)
    login_as user, scope: :user

    visit root_path
    within 'div#body_links' do
      click_on 'Promoções'
    end

    expect(page).to have_content('Natal')
    expect(page).to have_content('Promoção de Natal')
    expect(page).to have_content('10,00%')
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).not_to have_content('Nenhuma promoção cadastrada')
  end

  it 'and view details' do
    promotion = create(:promotion)
    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')

    user = create(:user)
    login_as user, scope: :user

    visit promotions_path
    click_on 'Cyber Monday'

    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('CYBER15')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('90')
  end

  it 'and no promotion are created' do
    user = create(:user)
    login_as user, scope: :user

    visit root_path
    within 'div#body_links' do
      click_on 'Promoções'
    end

    expect(page).to have_content('Nenhuma promoção cadastrada')
  end

  it 'and return to home page' do
    promotion = create(:promotion)
    user = create(:user)
    login_as user, scope: :user

    visit root_path
    within 'div#body_links' do
      click_on 'Promoções'
    end
    click_on 'Página Inicial'
    expect(page).to have_current_path root_path, ignore_query: true
  end

  it 'and return to promotions page' do
    promotion = create(:promotion)
    user = create(:user)
    login_as user, scope: :user

    visit root_path
    within 'div#body_links' do
      click_on 'Promoções'
    end
    click_on 'Dia do consumidor'
    click_on 'Voltar'

    expect(page).to have_current_path promotions_path, ignore_query: true
  end

  it 'and cannot view promotions unless logged in' do
    visit root_path
    within 'div#navbar_links' do
      click_on 'Promoções'
    end
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
    expect(page).to have_current_path(new_user_session_path, ignore_query: true)
  end

  it 'and cannot view promotions unless logged in via link' do
    promotion = create(:promotion)
    visit promotions_path

    expect(page).not_to have_content('Natal')
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
    expect(page).to have_current_path(new_user_session_path, ignore_query: true)
  end

  it 'and cannot view details unless logged in via link' do
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033')

    visit promotions_path(promotion)
    expect(page).not_to have_content('Natal')
    expect(page).not_to have_link('Editar')
    expect(page).not_to have_link('Deletar')
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

  it 'and cannot view edit unless logged in via link' do
    promotion = create(:promotion)
    visit edit_promotion_path(promotion)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end
end
