require 'rails_helper'

feature 'Admin edits a category' do
  
  scenario 'sucessfully' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
    login_as user, scope: :user
    
    visit product_categories_path
    click_on category.name
    click_on 'Editar'
    fill_in 'Nome', with: 'EMAIL'
    fill_in 'Código', with: 'EM10'
    click_on 'Criar categoria'
    visit product_categories_path
    expect(page).to have_content('EMAIL')
    expect(page).to have_content('EM10')
  end

  scenario 'and cannot edit unless logged in' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    visit product_categories_path(category)
    expect(page).to_not have_content(category)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end

end