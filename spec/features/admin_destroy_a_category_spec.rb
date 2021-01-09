require 'rails_helper'

feature 'Admin destroys a category' do
  
  scenario 'sucessfully' do
    category = ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')

    visit product_categories_path
    click_on category.name
    expect(current_path).to eq(product_category_path(ProductCategory.last))
    click_on 'Deletar'
    
    visit product_categories_path
    expect(page).to_not have_content(category)
  end

end
