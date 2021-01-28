require 'rails_helper'

feature 'Admin registers a valid category' do

  scenario 'successfully' do
    user = create(:user)
    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de produto'
    click_on 'Registrar uma categoria'
    fill_in 'Nome', with: 'HOSPEDAGEM'
    fill_in 'Código', with: 'HOSP'
    click_on 'Criar categoria'
    expect(current_path).to eq(product_category_path(ProductCategory.last))
    expect(page).to have_content('HOSPEDAGEM')
    expect(page).to have_content('HOSP')
    expect(page).to have_link('Voltar')
  end

  scenario 'and attributes cannot be blank' do
    user = create(:user)
    login_as user, scope: :user
    visit product_categories_path
    click_on 'Registrar uma categoria'
    click_on 'Criar categoria'
    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  scenario 'and code must be unique' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    user = create(:user)
    login_as user, scope: :user
    
    visit product_categories_path
    click_on 'Registrar uma categoria'
    fill_in 'Nome', with: 'SITES'
    fill_in 'Código', with: 'HOSP'
    click_on 'Criar categoria'

    expect(page).to have_content('deve ser único')
  end

end