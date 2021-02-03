require 'rails_helper'

describe 'Admin destroys a category' do
  it 'sucessfully' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    user = create(:user)
    login_as user, scope: :user

    visit product_categories_path
    click_on category.name
    expect(page).to have_current_path(product_category_path(ProductCategory.last), ignore_query: true)
    click_on 'Deletar'

    visit product_categories_path
    expect(page).not_to have_content(category)
  end

  it 'cannot delete unless logged in' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    visit product_categories_path(category)
    expect(page).not_to have_content(category)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end
