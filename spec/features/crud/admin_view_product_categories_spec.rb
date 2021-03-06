require 'rails_helper'

describe 'ProductCategory' do
  it 'successfully' do
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    ProductCategory.create!(name: 'E-mail', code: 'EMAIL')
    user = create(:user)
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias de produto'

    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('HOSP')
    expect(page).to have_content('E-mail')
    expect(page).to have_content('EMAIL')
  end

  it 'and show empty message' do
    user = create(:user)
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias de produto'
    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  it 'and view details' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    user = create(:user)
    login_as user, scope: :user

    visit product_categories_path

    click_on 'Hospedagem'
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('HOSP')
  end

  it 'and cannot view categories unless logged in' do
    visit root_path
    expect(page).not_to have_link('Categorias de produto')
  end

  it 'and cannot view categories unless logged in via link' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')

    visit product_categories_path

    expect(page).not_to have_content('Hospedagem')
    expect(page).not_to have_link('Categorias de produto')
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end

  it 'and cannot view category details unless logged in via link' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')

    visit product_categories_path(category)

    expect(page).not_to have_content('Hospedagem')
    expect(page).not_to have_link('Editar')
    expect(page).not_to have_link('Deletar')
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end

  it 'and cannot view category edit unless logged in via link' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    visit edit_product_category_path(category)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end
