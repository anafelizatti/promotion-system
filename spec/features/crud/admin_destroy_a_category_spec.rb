require 'rails_helper'

feature 'Admin destroys a category' do
  
  scenario 'sucessfully' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')
    login_as user, scope: :user

    visit product_categories_path
    click_on category.name
    expect(current_path).to eq(product_category_path(ProductCategory.last))
    click_on 'Deletar'
    
    visit product_categories_path
    expect(page).to_not have_content(category)
  end

  scenario 'cannot delete unless logged in' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    visit product_categories_path(category)
    expect(page).to_not have_content(category)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end

end
