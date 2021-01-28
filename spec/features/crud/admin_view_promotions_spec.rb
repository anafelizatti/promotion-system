require 'rails_helper'

feature 'Admin view promotions' do
  scenario 'successfully' do
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
    click_on 'Promoções'

    expect(page).to have_content('Natal')
    expect(page).to have_content('Promoção de Natal')
    expect(page).to have_content('10,00%')
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to_not have_content('Nenhuma promoção cadastrada')
  end

  scenario 'and view details' do

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

  scenario 'and no promotion are created' do

    user = create(:user)
    login_as user, scope: :user

    visit root_path
    click_on 'Promoções'

    expect(page).to have_content('Nenhuma promoção cadastrada')
  end

  scenario 'and return to home page' do
    promotion = create(:promotion)
    user = create(:user)
    login_as user, scope: :user

    visit root_path
    click_on 'Promoções'
    click_on 'Página Inicial'
    expect(current_path).to eq root_path
  end

  scenario 'and return to promotions page' do
      promotion = create(:promotion)
      user = create(:user)
      login_as user, scope: :user

      visit root_path
      click_on 'Promoções'
      click_on 'Dia do consumidor'
      click_on 'Voltar'

      expect(current_path).to eq promotions_path
    end 

    scenario 'and cannot view promotions unless logged in' do
      visit root_path
      
      expect(page).to_not have_link('Promoções')
    end

    scenario 'and cannot view promotions unless logged in via link' do
      promotion = create(:promotion)
      visit promotions_path

      expect(page).to_not have_content('Natal')
      expect(page).to_not have_link('Promoções')
      expect(current_path).to eq(new_user_session_path)
    end

  scenario 'and cannot view details unless logged in via link' do
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
    expiration_date: '22/12/2033')

      visit promotions_path(promotion)
      expect(page).to_not have_content('Natal')
      expect(page).to_not have_link('Editar')
      expect(page).to_not have_link('Deletar')
      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

  scenario 'and cannot view edit unless logged in via link' do
    promotion = create(:promotion)
      visit edit_promotion_path(promotion)
      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end
  

end
