require 'rails_helper'

feature 'Admin registers a valid category' do

  scenario 'successfully' do
    visit root_path
    click_on 'Categorias de produto'
    click_on 'Registrar uma categoria'
    fill_in 'Nome', with: 'HOSPEDAGEM'
    fill_in 'Código', with: 'HOSP'
    click_on 'Criar categoria'
    #expect(current_path).to eq(product_categories_path(ProductCategory.last))
    expect(page).to have_content('HOSPEDAGEM')
    expect(page).to have_content('HOSP')
    expect(page).to have_link('Voltar')
  end
end