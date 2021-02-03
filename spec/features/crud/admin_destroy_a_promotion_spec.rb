require 'rails_helper'

describe 'Promotion' do
  it 'sucessfully' do
    promotion = create(:promotion)
    user = create(:user)
    login_as user, scope: :user

    visit promotions_path
    click_on promotion.name
    click_on 'Deletar'

    visit promotions_path
    expect(page).not_to have_content(promotion)
    expect(page).to have_current_path promotions_path, ignore_query: true
  end

  it 'cannot delete unless logged in' do
    promotion = create(:promotion)
    visit promotions_path(promotion)
    expect(page).not_to have_content(promotion)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end
