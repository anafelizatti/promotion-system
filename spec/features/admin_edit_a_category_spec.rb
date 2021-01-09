require 'rails_helper'

feature 'Admin edits a category' do
  
  scenario 'sucessfully' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
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

end