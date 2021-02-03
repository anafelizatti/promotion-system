require 'rails_helper'

describe 'ProductCategory' do
  it 'successfully' do
    user = create(:user)
    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de produto'
    click_on 'Registrar uma categoria'
    fill_in 'Nome', with: 'HOSPEDAGEM'
    fill_in 'Código', with: 'HOSP'
    click_on 'Salvar categoria'
    expect(page).to have_current_path(product_category_path(ProductCategory.last), ignore_query: true)
    expect(page).to have_content('HOSPEDAGEM')
    expect(page).to have_content('HOSP')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    user = create(:user)
    login_as user, scope: :user
    visit product_categories_path
    click_on 'Registrar uma categoria'
    click_on 'Salvar categoria'
    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and code must be unique' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    user = create(:user)
    login_as user, scope: :user

    visit product_categories_path
    click_on 'Registrar uma categoria'
    fill_in 'Nome', with: 'SITES'
    fill_in 'Código', with: 'HOSP'
    click_on 'Salvar categoria'

    expect(page).to have_content('Código já está em uso')
  end
end