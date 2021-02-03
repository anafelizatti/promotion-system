require 'rails_helper'

describe 'Admin edits a category' do
  it 'sucessfully' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    user = create(:user)
    login_as user, scope: :user

    visit product_categories_path
    click_on category.name
    click_on 'Editar'
    fill_in 'Nome', with: 'EMAIL'
    fill_in 'Código', with: 'EM10'
    click_on 'Salvar categoria'
    visit product_categories_path
    expect(page).to have_content('EMAIL')
    expect(page).to have_content('EM10')
  end

  it 'and cannot edit unless logged in' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    visit product_categories_path(category)
    expect(page).not_to have_content(category)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end