require 'rails_helper'

describe 'Promotion' do
  xit 'Promotion receptor user can authorizes a promotion' do
    promotion = create(:promotion)
    source_user = User.create!(id: 1, email: 'admin@locaweb.com.br', password: '123456')
    receptor_user = User.create!(id: 2, email: 'admin2@locaweb.com.br', password: '123456')
    promotion.source_user_id = source_user.id

    login_as receptor_user, scope: :user
    visit promotions_path(promotion)
    click_on 'Autorizar'

    expect(page).to have_content('Status: Autorizada')
    expect(page).to have_link('Emitir cupons')
    expect(page).not_to have_link('Autorizar')
    expect(page).to have_link('Reprovar')
  end

  xit 'Promotion source user cannot authorizes its own promotions' do
    promotion = create(:promotion)
    source_user = User.create!(id: 1, email: 'admin@locaweb.com.br', password: '123456')
    promotion.source_user_id = source_user.id
    promotion.update

    login_as source_user, scope: :user
    visit promotions_path(promotion)

    visit promotions_path(promotion)
    expect(page).to have_content('Status: Aguardando avaliação')
    expect(page).not_to have_link('Emitir cupons')
    expect(page).not_to have_link('Autorizar')
    expect(page).not_to have_link('Reprovar')
  end
end
