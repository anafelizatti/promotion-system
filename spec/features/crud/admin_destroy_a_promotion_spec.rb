require 'rails_helper'

feature 'Admin destroys a promotion' do
  
  scenario 'sucessfully' do
    promotion = create(:promotion)
    user = create(:user)
    login_as user, scope: :user

    visit promotions_path
    click_on promotion.name
    click_on 'Deletar'
    
    visit promotions_path
    expect(page).to_not have_content(promotion)
    expect(current_path).to eq promotions_path
  end

  scenario 'cannot delete unless logged in' do
    promotion = create(:promotion)
    visit promotions_path(promotion)
    expect(page).to_not have_content(promotion)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end

end
